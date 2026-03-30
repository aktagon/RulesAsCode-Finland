# RulesAsCode-Finland

Finnish social security law is public. The systems that execute it should be too.

This project encodes section 6 of the Unemployment Security Act ([Työttömyysturvalaki 1290/2002 §6](https://www.finlex.fi/fi/laki/ajantasa/2002/20021290#L1P6)) as executable logic using [s(CASP)](https://github.com/SWI-Prolog/sCASP). The rules determine whether a person is classified as an entrepreneur (_yrittäjä_) — a classification that affects unemployment benefit eligibility.

The system produces Finnish-language justification trees that explain _why_ a decision was made. Not just the answer. The reasoning.

```
matti on yrittäjä, because
   matti on yrityksen osaomistaja, because
      ex_oy on osakeyhtiö, and
      matti työskentelee johtavassa asemassa yrityksessä ex_oy, because
         ex_oy on osakeyhtiö, and
         matti on ex_oy:n toimitusjohtaja
      matti:n tosiasiallinen omistusosuus yrityksessä ex_oy on 20%, because
         matti omistaa 20% ex_oy:n osakepääomasta tai äänimäärästä
      20% on vähintään 15%
```

Every rule traces to a specific paragraph of the statute.

## Why s(CASP)

s(CASP) reasons under the open-world assumption. Unstated facts are unknown, not false. This is how law works — a person not in the database is not "not an entrepreneur." Their status is unknown.

Closed-world systems (SQL, Python, conventional rule engines) get this wrong. They treat missing data as negation. s(CASP) treats it as absence of evidence, which is a fundamentally different thing.

The justification tree is not a side effect. It is the product.

## Quick Start

```bash
docker build -t rules-as-code .
```

Run the example query (Matti, CEO of a limited company, 20% ownership):

```bash
docker run --rm --entrypoint scasp rules-as-code \
    --tree --human src/entrepreneur.pl facts/example.pl
```

Run all 18 tests:

```bash
make test
```

## What Is Encoded

All of section 6:

- **§6(1)** — YEL and MYEL pension coverage as entrepreneur grounds
- **§6(2) items 1-4** — Part-owner conditions with ownership thresholds (15%, 30%, 50%) for limited companies and other entities
- **§6(3)** — Direct and indirect ownership through intermediate entities, including equivalent control
- **§6(4)** — Leadership position definition (CEO, board member, equivalent) scoped to company type. Family member definition (spouse, lineal relatives in same household)

Symmetric relations (spouse, same household, lineal relative) are enforced — facts can be asserted in either direction. Family share aggregation across multiple members is handled via pre-computation at the data boundary.

## Test Scenarios

| ID   | Scenario                                                | Expected                |
| ---- | ------------------------------------------------------- | ----------------------- |
| T01  | YEL-covered person                                      | entrepreneur            |
| T02  | MYEL-covered person                                     | entrepreneur            |
| T03  | CEO of ltd, 20% ownership                               | entrepreneur (item 1)   |
| T04  | CEO of ltd, 10% + spouse 25% = 35%                      | entrepreneur (item 2)   |
| T05  | Worker in ltd, 50% ownership                            | entrepreneur (item 3)   |
| T06  | Worker in ltd, 20% + spouse 35% = 55%                   | entrepreneur (item 3)   |
| T07  | Equivalent leadership in non-ltd, 15%                   | entrepreneur (item 4)   |
| T08  | Equivalent leadership in non-ltd, family 30%            | entrepreneur (item 4)   |
| T09  | Indirect ownership via holding company                  | entrepreneur (item 1)   |
| T09b | Equivalent control over holding company                 | entrepreneur            |
| T10  | Worker in ltd, 14% (below 15% threshold)                | not entrepreneur        |
| T11  | Board member of ltd, family combined 29% (below 30%)    | not entrepreneur        |
| T12  | Worker in ltd, no ownership, no YEL/MYEL                | not entrepreneur        |
| T13  | Person holds 20% but does not work in company           | not entrepreneur        |
| T14  | Sibling holds 20% (not a family member under §6)        | not entrepreneur        |
| T15  | Lineal relative not in same household                   | not entrepreneur        |
| T16  | CEO, spouse 12% + parent 10% = multi-member aggregation | entrepreneur (item 2)   |
| T04b | Same as T04, spouse fact asserted in reverse direction  | entrepreneur (symmetry) |

## Project Structure

```
src/entrepreneur.pl     §6 rules + Finnish #pred directives
test/t01-t16.pl         Per-scenario test files
facts/example.pl        Example fact base with query
Dockerfile              SWI-Prolog stable + s(CASP)
Makefile                build, run, query, test
```

## Ambiguity Findings

Encoding law as formal logic exposes where the statute resists computation. Section 6 has 14 such points across 5 types:

| Type                | Count | Example                                                         |
| ------------------- | ----- | --------------------------------------------------------------- |
| Undefined term      | 6     | "Equivalent control" — no computable definition in §6           |
| Aggregation gap     | 2     | Family shares must be summed; s(CASP) cannot aggregate natively |
| Implicit bound      | 2     | Indirect ownership depth not specified by statute               |
| Symmetry assumption | 3     | Resolved — spouse/household/relative now enforce symmetry       |
| Scope leak          | 1     | Resolved — CEO/board scoped to limited companies                |

Four were resolved in code. The rest are inherent to the statute.

## References

- [Työttömyysturvalaki 1290/2002 §6](https://www.finlex.fi/fi/laki/ajantasa/2002/20021290#L1P6) — source law (Finlex)
- [s(CASP) on SWI-Prolog](https://github.com/SWI-Prolog/sCASP) — goal-directed answer set programming with constraints
- [SWI-Prolog](https://www.swi-prolog.org/) — host runtime
- [Eepos — Kela's social security system programme](https://www.kela.fi/eepos)
- [Yle: Pian kone päättää suuresta osasta Kelan tukia](https://yle.fi/a/74-20211538) — Kela's plan to automate 80% of benefit decisions using Salesforce/PwC (589M EUR)

## License

[EUPL-1.2](LICENSE)

Built by [Aktagon Ltd.](https://aktagon.com)
