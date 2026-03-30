% T04: CEO of ltd, personal share = 10%, family share = 25% (total 35%) → entrepreneur (item 2)
limited_company(ex_oy).
ceo(david, ex_oy).
works_in(david, ex_oy).
direct_share(david, ex_oy, 10).
spouse_fact(david, diana).
same_household_fact(david, diana).
direct_share(diana, ex_oy, 25).
family_direct_share_sum(david, ex_oy, 25).
?- entrepreneur(david).
