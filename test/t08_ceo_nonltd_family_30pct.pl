% T08: Equivalent leadership in non-ltd entity, family combined share = 30% → entrepreneur (item 4)
equivalent_leadership(hans, ky).
works_in(hans, ky).
direct_share(hans, ky, 10).
spouse_fact(hans, hanna).
same_household_fact(hans, hanna).
direct_share(hanna, ky, 20).
family_direct_share_sum(hans, ky, 20).
?- entrepreneur(hans).
