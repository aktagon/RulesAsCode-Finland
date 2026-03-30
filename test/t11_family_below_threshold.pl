% T11: Board member of ltd, personal share = 14%, family combined = 29% → not entrepreneur
limited_company(ex_oy).
board_member(kaisa, ex_oy).
works_in(kaisa, ex_oy).
direct_share(kaisa, ex_oy, 14).
spouse_fact(kaisa, kalle).
same_household_fact(kaisa, kalle).
direct_share(kalle, ex_oy, 15).
family_direct_share_sum(kaisa, ex_oy, 15).
?- not entrepreneur(kaisa).
