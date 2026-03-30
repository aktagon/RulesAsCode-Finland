% T04b: Same as T04 but spouse_fact asserted in reverse direction
% Verifies symmetry enforcement — must produce same result as T04
limited_company(ex_oy).
ceo(david, ex_oy).
works_in(david, ex_oy).
direct_share(david, ex_oy, 10).
spouse_fact(diana, david).
same_household_fact(diana, david).
direct_share(diana, ex_oy, 25).
family_direct_share_sum(david, ex_oy, 25).
?- entrepreneur(david).
