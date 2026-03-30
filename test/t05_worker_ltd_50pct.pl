% T05: Worker in ltd, personal share = 50% → entrepreneur (item 3)
limited_company(ex_oy).
works_in(eero, ex_oy).
direct_share(eero, ex_oy, 50).
?- entrepreneur(eero).
