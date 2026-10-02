import type { PersonImportRow } from '@/gql/graphql';

export type ImportField = keyof PersonImportRow;

export const IMPORT_FIELDS: ImportField[] = [
  'firstName',
  'lastName',
  'birthDate',
  'birthPlace',
  'taxCode',
  'gender',
  'email',
  'phone',
  'addressLine',
  'city',
  'province',
  'postalCode',
  'teamName',
  'jerseyNumber',
  'guardianFirstName',
  'guardianLastName',
  'guardianEmail',
  'guardianPhone',
];

// Intestazioni tipiche dei fogli delle società (italiano e inglese), confrontate senza accenti, spazi e punteggiatura.
const SYNONYMS: Record<ImportField, string[]> = {
  firstName: ['nome', 'firstname', 'name'],
  lastName: ['cognome', 'lastname', 'surname'],
  birthDate: ['datadinascita', 'datanascita', 'nascita', 'birthdate', 'dateofbirth', 'dob'],
  birthPlace: ['luogodinascita', 'luogonascita', 'natoa', 'birthplace', 'placeofbirth'],
  taxCode: ['codicefiscale', 'cf', 'codfiscale', 'taxcode'],
  gender: ['sesso', 'genere', 'gender', 'sex'],
  email: ['email', 'mail', 'posta', 'emailatleta'],
  phone: ['telefono', 'cellulare', 'cell', 'tel', 'phone', 'mobile'],
  addressLine: ['indirizzo', 'via', 'residenza', 'address'],
  city: ['comune', 'citta', 'city', 'localita'],
  province: ['provincia', 'prov', 'province'],
  postalCode: ['cap', 'postalcode', 'zip'],
  teamName: ['squadra', 'categoria', 'team', 'gruppo'],
  jerseyNumber: ['maglia', 'numero', 'numeromaglia', 'jersey', 'shirt'],
  guardianFirstName: ['nomegenitore', 'nometutore', 'nomemadre', 'nomepadre', 'guardianfirstname', 'parentfirstname'],
  guardianLastName: ['cognomegenitore', 'cognometutore', 'guardianlastname', 'parentlastname'],
  guardianEmail: ['emailgenitore', 'mailgenitore', 'emailtutore', 'guardianemail', 'parentemail'],
  guardianPhone: ['telefonogenitore', 'cellularegenitore', 'telefonotutore', 'guardianphone', 'parentphone'],
};

function normalize(header: string): string {
  return header
    .normalize('NFD')
    .replace(/[̀-ͯ]/g, '')
    .toLowerCase()
    .replace(/[^a-z0-9]/g, '');
}

/** Collega automaticamente le colonne del file ai campi Huddle; ogni campo al più una volta. */
export function autoMap(headers: string[]): (ImportField | '')[] {
  const used = new Set<ImportField>();
  return headers.map((h) => {
    const n = normalize(h);
    const field = IMPORT_FIELDS.find((f) => !used.has(f) && SYNONYMS[f].includes(n));
    if (field) used.add(field);
    return field ?? '';
  });
}

/** Converte una cella in testo; le date di Excel diventano YYYY-MM-DD. */
export function cellToString(value: unknown): string {
  if (value === null || value === undefined) return '';
  if (value instanceof Date) return value.toISOString().slice(0, 10);
  return String(value).trim();
}

export function buildRows(data: unknown[][], mapping: (ImportField | '')[]): PersonImportRow[] {
  return data
    .map((cells) => {
      const row: PersonImportRow = {};
      mapping.forEach((field, i) => {
        if (!field) return;
        const value = cellToString(cells[i]);
        if (!value) return;
        if (field === 'jerseyNumber') {
          const n = Number(value);
          if (Number.isInteger(n)) row.jerseyNumber = n;
        } else {
          row[field] = value;
        }
      });
      return row;
    })
    .filter((row) => Object.keys(row).length > 0);
}
