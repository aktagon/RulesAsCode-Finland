% Entrepreneur Definition — Työttömyysturvalaki 1290/2002 §6
% Encoding of the legal definition of an entrepreneur (yrittäjä)
% using s(CASP) for open-world reasoning with justification trees.

% ---------------------------------------------------------------------------
% Finnish-language justification tree predicates (#pred directives)
% ---------------------------------------------------------------------------

#pred entrepreneur(P) :: '@(P) on yrittäjä'.
#pred not entrepreneur(P) :: '@(P) ei ole yrittäjä'.

#pred yel_entrepreneur(P) :: '@(P) on YEL-vakuutettu (yrittäjän eläkelaki 1272/2006 §3)'.
#pred myel_entrepreneur(P) :: '@(P) on MYEL-vakuutettu (maatalousyrittäjän eläkelaki 1280/2006 §§3-5)'.

#pred part_owner(P) :: '@(P) on yrityksen osaomistaja'.
#pred not part_owner(P) :: '@(P) ei ole yrityksen osaomistaja'.

#pred works_in_leadership(P, C) :: '@(P) työskentelee johtavassa asemassa yrityksessä @(C)'.
#pred not works_in_leadership(P, C) :: '@(P) ei työskentele johtavassa asemassa yrityksessä @(C)'.

#pred ceo(P, C) :: '@(P) on @(C):n toimitusjohtaja'.
#pred not ceo(P, C) :: '@(P) ei ole @(C):n toimitusjohtaja'.
#pred board_member(P, C) :: '@(P) on @(C):n hallituksen jäsen'.
#pred not board_member(P, C) :: '@(P) ei ole @(C):n hallituksen jäsen'.
#pred equivalent_leadership(P, C) :: '@(P):lla on vastaava johtava asema yrityksessä @(C)'.
#pred not equivalent_leadership(P, C) :: '@(P):lla ei ole vastaavaa johtavaa asemaa yrityksessä @(C)'.

#pred works_in(P, C) :: '@(P) työskentelee yrityksessä @(C)'.
#pred not works_in(P, C) :: '@(P) ei työskentele yrityksessä @(C)'.
#pred limited_company(C) :: '@(C) on osakeyhtiö'.
#pred not limited_company(C) :: '@(C) ei ole osakeyhtiö'.

#pred direct_share(P, C, S) :: '@(P) omistaa @(S)% @(C):n osakepääomasta tai äänimäärästä'.
#pred not direct_share(P, C, S) :: '@(P) ei omista osuutta @(C):n osakepääomasta tai äänimäärästä'.
#pred effective_share(P, C, S) :: '@(P):n tosiasiallinen omistusosuus yrityksessä @(C) on @(S)%'.
#pred not effective_share(P, C, S) :: '@(P):lla ei ole tosiasiallista omistusosuutta yrityksessä @(C)'.
#pred family_combined_share(P, C, S) :: '@(P):n ja perheen yhteenlaskettu omistusosuus yrityksessä @(C) on @(S)%'.
#pred not family_combined_share(P, C, S) :: '@(P):lla ja perheellä ei ole riittävää yhteenlaskettua omistusosuutta yrityksessä @(C)'.
#pred family_direct_share_sum(P, C, S) :: '@(P):n perheenjäsenten suorien omistusosuuksien summa yrityksessä @(C) on @(S)% (esilaskettu)'.
#pred not family_direct_share_sum(P, C, S) :: '@(P):n perheenjäsenillä ei ole suoria omistusosuuksia yrityksessä @(C)'.

#pred family_member(W, F) :: '@(F) on @(W):n perheenjäsen'.
#pred not family_member(W, F) :: '@(F) ei ole @(W):n perheenjäsen'.
#pred spouse(A, B) :: '@(A) ja @(B) ovat puolisoita'.
#pred not spouse(A, B) :: '@(A) ja @(B) eivät ole puolisoita'.
#pred lineal_relative(A, B) :: '@(A) ja @(B) ovat sukulaisia suoraan ylenevässä tai alenevässä polvessa'.
#pred not lineal_relative(A, B) :: '@(A) ja @(B) eivät ole sukulaisia suoraan ylenevässä tai alenevässä polvessa'.
#pred same_household(A, B) :: '@(A) ja @(B) asuvat samassa taloudessa'.
#pred not same_household(A, B) :: '@(A) ja @(B) eivät asu samassa taloudessa'.

% ---------------------------------------------------------------------------
% Symmetric relations — facts may be asserted in either direction
% Assert spouse_fact/2, lineal_relative_fact/2, same_household_fact/2.
% The derived predicates ensure symmetry regardless of assertion order.
% ---------------------------------------------------------------------------

spouse(A, B) :- spouse_fact(A, B).
spouse(A, B) :- spouse_fact(B, A).

lineal_relative(A, B) :- lineal_relative_fact(A, B).
lineal_relative(A, B) :- lineal_relative_fact(B, A).

same_household(A, B) :- same_household_fact(A, B).
same_household(A, B) :- same_household_fact(B, A).

#pred equivalent_control(P, C, S) :: '@(P):lla on vastaava määräämisvalta (@(S)%) yrityksessä @(C)'.

#pred share_at_least(S, T) :: '@(S)% on vähintään @(T)%'.
#pred not share_at_least(S, T) :: '@(S)% ei ole vähintään @(T)%'.

% ---------------------------------------------------------------------------
% Threshold comparison (wrapper for Finnish justification output)
% ---------------------------------------------------------------------------

share_at_least(S, Threshold) :- S >= Threshold.

% ---------------------------------------------------------------------------
% §6(1) — YEL and MYEL entrepreneurs
% ---------------------------------------------------------------------------

entrepreneur(P) :- yel_entrepreneur(P).
entrepreneur(P) :- myel_entrepreneur(P).

% ---------------------------------------------------------------------------
% §6(2) — Part-owner as entrepreneur
% ---------------------------------------------------------------------------

entrepreneur(P) :- part_owner(P).

% §6(2) item 1 — Leadership + personal ownership >= 15% in ltd
part_owner(P) :-
    limited_company(C),
    works_in_leadership(P, C),
    effective_share(P, C, S),
    share_at_least(S, 15).

% §6(2) item 2 — Leadership + family combined ownership >= 30% in ltd
part_owner(P) :-
    limited_company(C),
    works_in_leadership(P, C),
    family_combined_share(P, C, S),
    share_at_least(S, 30).

% §6(2) item 3 — Works + personal ownership >= 50% in ltd
part_owner(P) :-
    limited_company(C),
    works_in(P, C),
    effective_share(P, C, S),
    share_at_least(S, 50).

% §6(2) item 3 — Works + family combined ownership >= 50% in ltd
part_owner(P) :-
    limited_company(C),
    works_in(P, C),
    family_combined_share(P, C, S),
    share_at_least(S, 50).

% §6(2) item 4 — Equivalent conditions in non-ltd entity (leadership + personal >= 15%)
part_owner(P) :-
    not limited_company(C),
    works_in_leadership(P, C),
    effective_share(P, C, S),
    share_at_least(S, 15).

% §6(2) item 4 — Equivalent conditions in non-ltd entity (leadership + family >= 30%)
part_owner(P) :-
    not limited_company(C),
    works_in_leadership(P, C),
    family_combined_share(P, C, S),
    share_at_least(S, 30).

% ---------------------------------------------------------------------------
% §6(4) — Leadership position
% ---------------------------------------------------------------------------

works_in_leadership(P, C) :- limited_company(C), ceo(P, C).
works_in_leadership(P, C) :- limited_company(C), board_member(P, C).
works_in_leadership(P, C) :- equivalent_leadership(P, C).

% ---------------------------------------------------------------------------
% §6(4) — Family member
% ---------------------------------------------------------------------------

family_member(W, S) :- works_in(W, _), spouse(W, S), same_household(W, S).
family_member(W, R) :- works_in(W, _), lineal_relative(W, R), same_household(W, R).

% ---------------------------------------------------------------------------
% §6(3) — Effective share (direct and indirect ownership)
% ---------------------------------------------------------------------------

% Direct ownership
effective_share(P, C, S) :- direct_share(P, C, S).

% Indirect via intermediate entity where person holds >= 50%
effective_share(P, C, S) :-
    direct_share(P, I, IS),
    share_at_least(IS, 50),
    direct_share(I, C, CS),
    S is IS * CS / 100.

% Indirect via intermediate entity where family combined holds >= 50%
effective_share(P, C, S) :-
    family_combined_share(P, I, IS),
    share_at_least(IS, 50),
    direct_share(I, C, CS),
    S is IS * CS / 100.

% Indirect via equivalent control over intermediate entity
effective_share(P, C, S) :-
    equivalent_control(P, I, _),
    direct_share(I, C, S).

% ---------------------------------------------------------------------------
% Family combined share (person's effective share + pre-computed family sum)
% The host layer pre-computes family_direct_share_sum/3 by summing
% direct_share of all family members. This avoids the per-member
% iteration that s(CASP) cannot aggregate. See AMBIGUITY-REPORT.md B1.
% ---------------------------------------------------------------------------

family_combined_share(P, C, S) :-
    effective_share(P, C, PS),
    family_direct_share_sum(P, C, FS),
    S is PS + FS.
