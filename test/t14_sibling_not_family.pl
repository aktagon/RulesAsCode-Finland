% T14: Sibling holds 20%, person holds 10%, person is CEO → not entrepreneur
% Sibling is not a family member under §6
limited_company(ex_oy).
ceo(niko, ex_oy).
works_in(niko, ex_oy).
direct_share(niko, ex_oy, 10).
direct_share(niko_sibling, ex_oy, 20).
?- not entrepreneur(niko).
