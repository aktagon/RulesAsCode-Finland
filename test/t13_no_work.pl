% T13: Spouse is board member, person holds 20% but does not work in company → not entrepreneur
limited_company(ex_oy).
board_member(maija_spouse, ex_oy).
works_in(maija_spouse, ex_oy).
direct_share(maija, ex_oy, 20).
spouse_fact(maija, maija_spouse).
same_household_fact(maija, maija_spouse).
?- not entrepreneur(maija).
