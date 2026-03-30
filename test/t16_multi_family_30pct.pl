% T16: CEO of ltd, personal share = 10%, spouse = 12%, parent = 10%
% Family direct share sum = 22%, combined = 32% >= 30% → entrepreneur (item 2)
% This test exercises multi-member aggregation (B1 fix).
limited_company(ex_oy).
ceo(ville, ex_oy).
works_in(ville, ex_oy).
direct_share(ville, ex_oy, 10).
direct_share(vilma, ex_oy, 12).
direct_share(ville_parent, ex_oy, 10).
family_direct_share_sum(ville, ex_oy, 22).
?- entrepreneur(ville).
