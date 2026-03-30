% T15: Lineal relative not in same household holds 25%, person holds 10%, person is CEO → not entrepreneur
limited_company(ex_oy).
ceo(olli, ex_oy).
works_in(olli, ex_oy).
direct_share(olli, ex_oy, 10).
lineal_relative_fact(olli, olli_parent).
direct_share(olli_parent, ex_oy, 25).
?- not entrepreneur(olli).
