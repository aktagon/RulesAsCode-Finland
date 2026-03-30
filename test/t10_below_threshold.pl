% T10: Worker in ltd, personal share = 14%, no family shares → not entrepreneur
limited_company(ex_oy).
works_in(juha, ex_oy).
direct_share(juha, ex_oy, 14).
?- not entrepreneur(juha).
