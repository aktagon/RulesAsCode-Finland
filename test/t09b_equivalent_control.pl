% T09b: CEO of ltd, equivalent control over holding, holding owns 80% of target
% Person has no shares in holding but controls it via shareholder agreement
limited_company(holding_oy).
limited_company(target_oy).
ceo(jari, target_oy).
equivalent_control(jari, holding_oy, 100).
direct_share(holding_oy, target_oy, 80).
?- entrepreneur(jari).
