% Example fact base for manual testing
% Scenario: CEO of a limited company with 20% ownership (T03)

limited_company(ex_oy).
ceo(matti, ex_oy).
direct_share(matti, ex_oy, 20).

?- entrepreneur(matti).
