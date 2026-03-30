% T06: Worker in ltd, personal share = 20%, family share = 35% (total 55%) → entrepreneur (item 3)
limited_company(ex_oy).
works_in(frank, ex_oy).
direct_share(frank, ex_oy, 20).
spouse_fact(frank, fiona).
same_household_fact(frank, fiona).
direct_share(fiona, ex_oy, 35).
family_direct_share_sum(frank, ex_oy, 35).
?- entrepreneur(frank).
