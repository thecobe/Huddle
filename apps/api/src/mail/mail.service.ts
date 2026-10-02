import { Inject, Injectable, Logger } from '@nestjs/common';
import nodemailer, { type Transporter } from 'nodemailer';
import { ENV, type Env } from '../config/env.js';
import { type MailTemplate, renderMail } from './templates.js';

export interface SentMail {
  to: string;
  subject: string;
  text: string;
}

@Injectable()
export class MailService {
  private readonly logger = new Logger(MailService.name);
  private readonly transporter: Transporter;
  /** Solo in test: messaggi inviati, per leggere i link nei test end-to-end. */
  readonly outbox: SentMail[] = [];

  constructor(@Inject(ENV) private readonly env: Env) {
    this.transporter =
      env.NODE_ENV === 'test'
        ? nodemailer.createTransport({ jsonTransport: true })
        : nodemailer.createTransport(env.SMTP_URL);
  }

  async send(to: string, locale: string, template: MailTemplate): Promise<void> {
    const { subject, text } = renderMail(locale, template);
    if (this.env.NODE_ENV === 'test') {
      this.outbox.push({ to, subject, text });
      return;
    }
    try {
      await this.transporter.sendMail({ from: this.env.MAIL_FROM, to, subject, text });
    } catch (err) {
      // L'invio e-mail non deve far fallire l'operazione: i job con retry arrivano con BullMQ in Fase 1.
      this.logger.error(`Invio e-mail fallito verso ${to}`, err as Error);
    }
  }
}
