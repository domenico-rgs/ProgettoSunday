function [f_alpha,f] = TestF(alpha, n, q,SSR1, SSR2)
f_alpha = finv(1-alpha, 1, n-q);
f=(n-q)*((SSR1-SSR2)/SSR2);
end

