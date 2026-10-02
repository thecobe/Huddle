const MAILPIT = process.env.MAILPIT_URL ?? 'http://localhost:8025';

/** Attende l'ultima e-mail inviata a `to` e ne restituisce il testo. */
export async function waitForMail(to: string, timeoutMs = 10_000): Promise<string> {
  const deadline = Date.now() + timeoutMs;
  while (Date.now() < deadline) {
    const res = await fetch(`${MAILPIT}/api/v1/search?query=${encodeURIComponent(`to:"${to}"`)}`);
    const body = (await res.json()) as { messages: { ID: string }[] };
    const id = body.messages[0]?.ID;
    if (id) {
      const msg = (await (await fetch(`${MAILPIT}/api/v1/message/${id}`)).json()) as { Text: string };
      return msg.Text;
    }
    await new Promise((r) => setTimeout(r, 300));
  }
  throw new Error(`Nessuna e-mail per ${to}`);
}

export function firstLink(text: string, pathPrefix: string): string {
  const match = text.match(new RegExp(`https?://[^\\s]+${pathPrefix}[^\\s]*`));
  if (!match) throw new Error(`Link ${pathPrefix} non trovato`);
  return match[0];
}
