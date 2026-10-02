import { describe, expect, it } from 'vitest';
import { autoMap, buildRows } from './import-mapping';

describe('collegamento colonne import', () => {
  it('riconosce le intestazioni italiane tipiche', () => {
    expect(autoMap(['Cognome', 'Nome', 'Data di nascita', 'Codice Fiscale', 'E-mail genitore', 'Città', 'Colonna strana'])).toEqual([
      'lastName',
      'firstName',
      'birthDate',
      'taxCode',
      'guardianEmail',
      'city',
      '',
    ]);
  });

  it('costruisce le righe, salta quelle vuote e converte date e numeri', () => {
    const rows = buildRows(
      [
        ['Rossi', 'Luca', new Date(Date.UTC(2014, 3, 10)), '7'],
        ['', '', null, ''],
      ],
      ['lastName', 'firstName', 'birthDate', 'jerseyNumber'],
    );
    expect(rows).toEqual([{ lastName: 'Rossi', firstName: 'Luca', birthDate: '2014-04-10', jerseyNumber: 7 }]);
  });
});
