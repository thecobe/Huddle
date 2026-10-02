import { Controller, Get, NotFoundException, Param, Res } from '@nestjs/common';
import type { Response } from 'express';
import { CalendarFeedService } from './calendar-feed.service.js';

/** Abbonamento iCal: URL con token, senza sessione (lo usano Google, Apple e Outlook). */
@Controller('calendar')
export class CalendarController {
  constructor(private readonly feeds: CalendarFeedService) {}

  @Get(':file')
  async feed(@Param('file') file: string, @Res() res: Response): Promise<void> {
    const token = file.endsWith('.ics') ? file.slice(0, -4) : file;
    if (!/^[A-Za-z0-9_-]{20,100}$/.test(token)) throw new NotFoundException();
    const body = await this.feeds.render(token);
    if (body === null) throw new NotFoundException();
    res
      .status(200)
      .type('text/calendar; charset=utf-8')
      .set('Cache-Control', 'private, max-age=300')
      .set('Content-Disposition', 'inline; filename="huddle.ics"')
      .send(body);
  }
}
