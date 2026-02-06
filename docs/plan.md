下面给你一套可以直接替换进论文的“完整修正方案”（含：需要改哪些地方、改成什么形式、以及对应的完整证明）。我会把你原来最容易被审稿人一眼否掉的点（“OR/AND 事件写反”“不等号方向写反”“把 block 间相关性当独立”“Hoeffding 适用条件没写”）全部修到逻辑自洽。

为方便你直接粘贴，我会用 LaTeX 可替换块 的形式给出：Assumptions、Lemmas、Theorems、Proofs，并给出“统一块大小”的化简式和如何选 T_p 达到 1-\alpha 的成功率。

⸻

A. 需要整体做的改动（修正方案总览）

A1. 统一符号：避免 P 冲突

你目前用 P 同时表示概率和 MPI 处理器数。这是硬伤。
	•	建议：
	•	概率统一用 p_{\mathrm{det}}、p_{\mathrm{fail}}、\Pr(\cdot)。
	•	处理器数用 P_{\mathrm{proc}} 或 n_{\mathrm{proc}}。

A2. 事件定义必须改：检测失败是 “OR”，不能用 “AND” 代替

对单个 block：
	•	block 成功：X\ge T_m 且 Y\ge T_n
	•	block 失败：(X<T_m)\ \mathbf{or}\ (Y<T_n)

你原证明把 “OR” 换成 “AND” 还当成上界，这是不成立的，会导致成功概率被严重高估。

正确做法：用
\Pr(X<T_m\ \text{or}\ Y<T_n)\le \Pr(X<T_m)+\Pr(Y<T_n)
（union bound），或者在行/列独立时写精确式
\Pr(X<T_m\ \text{or}\ Y<T_n)=1-(1-\Pr(X<T_m))(1-\Pr(Y<T_n)).

A3. 你真正需要分析的不是 \prod_{i,j}，而是“行侧存在 + 列侧存在”

对于矩形 co-cluster R_k\times C_k，在一次分区试验中：
	•	X_i=|R_k\cap I_i| 只依赖 row-block i
	•	Y_j=|C_k\cap J_j| 只依赖 col-block j

那么“存在某个 block (i,j) 同时满足阈值” 等价于：
(\exists i:\ X_i\ge T_m)\ \land\ (\exists j:\ Y_j\ge T_n).
这一步非常关键，它能让你避免原来那种不正确的 \prod_{i,j} 结构（也避免 m,n 因子混乱）。

A4. Hoeffding/Serfling 使用条件必须写清楚（否则你那个平方会被质疑）

你写的
\exp(-2\phi_i(s_i^{(k)})^2)
只有在
\mathbb{E}X_i > T_m-1
时才是有意义的“指数小上界”。否则只能给出 trivial bound 1。

因此建议把
s_i^{(k)}=\left(\frac{M^{(k)}}{M}-\frac{T_m-1}{\phi_i}\right)_+
用正部 (\cdot)_+ 修正，或者分段写。

A5. block 间不是独立的：给一个严格可用的版本（不依赖 block 独立）+ 一个“更紧但需引用负相关性质”的版本

为了让你论文更稳，我给你两层结果：
	•	版本（严格自洽，无需 block 独立/负相关引理）：
用 “若所有 blocks 都失败，则某个指定 block 也失败” 得到
\Pr(\forall i: X_i<T_m)\le \min_i \Pr(X_i<T_m)。
这个界比较松，但完全自洽、无需高级概率工具。
	•	版本（更紧，与你原来想要的“求和在指数里”形式接近）：
使用一个标准事实：随机置换切块得到的多元超几何计数向量具有负相关/负关联（negative association），从而
\Pr\Big(\bigcap_i \{X_i<T_m\}\Big)\le \prod_i \Pr(X_i<T_m),
这就给你指数里的 \sum_i\phi_i(s_i^{(k)})^2 结构。
这个事实是标准结论（可引用 Joag‑Dev & Proschan 1983 或 Dubhashi & Ranjan 1998 这类经典参考），审稿人通常接受。

⸻

B. 可直接替换的“修正后理论部分”（含完整证明）

下面这套内容你可以直接替换你论文中：
	•	\(\Cref{thm:joint-probability}\)（你现在那条“joint probability” lemma）
	•	\(\Cref{thm:probability-co-cluster-detection}\)（检测概率定理）
	•	以及 Appendix 对应 proof

我把结构写得更清晰，且每一步不等号方向都对。

⸻

B1. 修正后的 Assumptions（建议替换你原来的 probabilistic model assumptions）

\subsubsection{Probabilistic Model for Partitioning (Revised)}
\label{subsec:probabilistic-model-revised}

We analyze partitioning under the following randomized block model.

\begin{assumption}[Random permutation partitioning]
\label{assump:perm-partition}
In each trial $t=1,\dots,T_p$, we generate an independent random permutation of rows
and split the permuted indices into $m$ disjoint row blocks
$I_1^{(t)},\dots,I_m^{(t)}$ with fixed sizes $|I_i^{(t)}|=\phi_i$.
Similarly, we generate an independent random permutation of columns and split them into
$n$ disjoint column blocks $J_1^{(t)},\dots,J_n^{(t)}$ with $|J_j^{(t)}|=\psi_j$.
\end{assumption}

\begin{assumption}[Row/column independence across trials]
\label{assump:trial-indep}
Row permutations are independent of column permutations, and different trials are independent.
Hence, events determined only by row partitioning are independent from those determined only by
column partitioning, and are i.i.d. across trials.
\end{assumption}

\begin{assumption}[Rectangular co-cluster support]
\label{assump:rectangular}
Each co-cluster $C_k$ corresponds to a row index set $R_k\subseteq[M]$ and a column index set
$C_k^{\mathrm{col}}\subseteq[N]$, such that its support is $R_k\times C_k^{\mathrm{col}}$.
Let $|R_k|=M^{(k)}$ and $|C_k^{\mathrm{col}}|=N^{(k)}$.
\end{assumption}

\begin{assumption}[Significant co-clusters and thresholds]
\label{assump:thresholds}
A co-cluster is called \emph{significant} if $M^{(k)}\ge T_m$ and $N^{(k)}\ge T_n$.
\end{assumption}

说明：这里我把你的 “random boundary uniformly at random” 明确成 “随机置换后切块”。这是最标准、最好证明的模型，而且也符合分布式系统里常见的“shuffle + block”实现。

⸻

B2. 定义：每个 trial 的行/列命中数（替换你原来 M_{(i,j)}^{(k)} 的混乱双下标）

\paragraph{Row/column hits in blocks.}
Fix a co-cluster $k$ and a trial $t$.
Define the row hit count in row block $i$:
\[
X_{i,t}^{(k)} := |R_k \cap I_i^{(t)}|,
\]
and the column hit count in column block $j$:
\[
Y_{j,t}^{(k)} := |C_k^{\mathrm{col}} \cap J_j^{(t)}|.
\]
For any block $(i,j)$, the co-cluster portion inside the block has size
$X_{i,t}^{(k)}\times Y_{j,t}^{(k)}$.


⸻

B3. Lemma 1（修正）：超几何下界（你原 Lemma 的正确版本）

Lemma：单维阈值失败概率（完整证明）

\begin{lemma}[Hypergeometric lower-tail bound for block hits]
\label{lem:hyp-tail}
Under Assumption~\ref{assump:perm-partition}, for each fixed $k,i,t$,
$X_{i,t}^{(k)}$ follows a hypergeometric law with mean
$\mu_i^{(k)} = \mathbb{E}[X_{i,t}^{(k)}]=\phi_i\cdot \frac{M^{(k)}}{M}$.
Define
\[
\Delta_{i}^{(k)} := \mu_i^{(k)}-(T_m-1),
\qquad
s_i^{(k)} := \left(\frac{\Delta_i^{(k)}}{\phi_i}\right)_+
= \left(\frac{M^{(k)}}{M}-\frac{T_m-1}{\phi_i}\right)_+.
\]
Then
\begin{equation}
\Pr\!\left(X_{i,t}^{(k)} < T_m\right)
=\Pr\!\left(X_{i,t}^{(k)} \le T_m-1\right)
\le \exp\!\left(-2\phi_i (s_i^{(k)})^2\right).
\label{eq:row-tail}
\end{equation}
Similarly, for columns, letting
\[
\nu_j^{(k)}=\mathbb{E}[Y_{j,t}^{(k)}]=\psi_j\cdot \frac{N^{(k)}}{N},
\quad
t_j^{(k)} := \left(\frac{N^{(k)}}{N}-\frac{T_n-1}{\psi_j}\right)_+,
\]
we have
\begin{equation}
\Pr\!\left(Y_{j,t}^{(k)} < T_n\right)\le \exp\!\left(-2\psi_j (t_j^{(k)})^2\right).
\label{eq:col-tail}
\end{equation}
\end{lemma}

\begin{proof}
We prove \eqref{eq:row-tail}; \eqref{eq:col-tail} is identical.

Let the population values be $Z_1,\dots,Z_M\in\{0,1\}$ where
$Z_r=1$ iff $r\in R_k$. Then $\frac{1}{M}\sum_{r=1}^M Z_r = \frac{M^{(k)}}{M}$.
In trial $t$, the row block $I_i^{(t)}$ is a uniformly random subset of $[M]$
of size $\phi_i$ (by random permutation and cutting), hence
\[
X_{i,t}^{(k)}=\sum_{r\in I_i^{(t)}} Z_r
\]
is a sum of $\phi_i$ samples \emph{without replacement} from a bounded population.

A standard Hoeffding--Serfling inequality for sampling without replacement states that for any
$\varepsilon>0$,
\[
\Pr\!\left(\frac{1}{\phi_i}\sum_{r\in I_i^{(t)}} Z_r
\le \frac{1}{M}\sum_{r=1}^M Z_r - \varepsilon \right)
\le \exp(-2\phi_i\varepsilon^2).
\]
Set $\varepsilon = \left(\frac{M^{(k)}}{M}-\frac{T_m-1}{\phi_i}\right)_+=s_i^{(k)}$.
Then
\[
\Pr(X_{i,t}^{(k)}\le T_m-1)
=\Pr\!\left(\frac{X_{i,t}^{(k)}}{\phi_i}\le \frac{T_m-1}{\phi_i}\right)
\le \exp\!\left(-2\phi_i (s_i^{(k)})^2\right),
\]
which proves \eqref{eq:row-tail}.
\end{proof}

你原来最大的问题之一就是把 s_i^{(k)} 允许为负还平方，这会产生“明明期望比阈值小，概率还指数小”的荒谬。这里用 (\cdot)_+ 一次性修掉。

⸻

B4. Lemma 2（修正）：单个 block 的 OR/AND 关系（你原 “joint probability” 必须重写）

你原 Lemma 写的是
\Pr(X<T_m, Y<T_n)\le \exp(-2\phi s^2-2\psi t^2)，这本身可以成立（在行列独立时），但它不是 block 失败事件，只能算一个“更严格的子事件”。

我建议你保留 AND 版本作为“辅助引理”，并同时给出真正需要的 OR 版本：

\begin{lemma}[Within-block failure bounds (AND vs OR)]
\label{lem:block-fail}
Fix $k,i,j,t$. Under Assumption~\ref{assump:trial-indep}, $X_{i,t}^{(k)}$ and $Y_{j,t}^{(k)}$
are independent. Hence
\begin{align}
\Pr\!\left(X_{i,t}^{(k)}<T_m,\ Y_{j,t}^{(k)}<T_n\right)
&=\Pr(X_{i,t}^{(k)}<T_m)\Pr(Y_{j,t}^{(k)}<T_n) \nonumber\\
&\le \exp\!\left(-2\phi_i (s_i^{(k)})^2 -2\psi_j (t_j^{(k)})^2\right).
\label{eq:and-bound}
\end{align}
Moreover, the true block failure event is
$\{X_{i,t}^{(k)}<T_m \ \text{or}\ Y_{j,t}^{(k)}<T_n\}$, for which
\begin{equation}
\Pr\!\left(X_{i,t}^{(k)}<T_m \ \text{or}\ Y_{j,t}^{(k)}<T_n\right)
\le \exp\!\left(-2\phi_i (s_i^{(k)})^2\right)+\exp\!\left(-2\psi_j (t_j^{(k)})^2\right).
\label{eq:or-bound}
\end{equation}
\end{lemma}

\begin{proof}
\eqref{eq:and-bound} follows from independence and Lemma~\ref{lem:hyp-tail}.
For \eqref{eq:or-bound}, apply the union bound:
\[
\Pr(A\cup B)\le \Pr(A)+\Pr(B),
\]
with $A=\{X_{i,t}^{(k)}<T_m\}$ and $B=\{Y_{j,t}^{(k)}<T_n\}$, then use
Lemma~\ref{lem:hyp-tail}.
\end{proof}


⸻

B5. Lemma 3（关键）：一次 trial 是否捕获 co-cluster 的等价事件（避免你原来错误的 \prod_{i,j}）

\begin{lemma}[Trial-level detection equivalence]
\label{lem:trial-equivalence}
Fix a co-cluster $k$ and a trial $t$.
Define the row-success event $S_{\mathrm{row}}^{(k,t)}:=\{\exists i:\ X_{i,t}^{(k)}\ge T_m\}$
and the column-success event $S_{\mathrm{col}}^{(k,t)}:=\{\exists j:\ Y_{j,t}^{(k)}\ge T_n\}$.
Then co-cluster $k$ is captured in trial $t$ (i.e., there exists a block $(i,j)$ such that
$X_{i,t}^{(k)}\ge T_m$ and $Y_{j,t}^{(k)}\ge T_n$) if and only if
\[
S_{\mathrm{row}}^{(k,t)} \ \land\ S_{\mathrm{col}}^{(k,t)}.
\]
Equivalently, the miss event in a trial is
\[
F_{k,t} = \left(\forall i,\ X_{i,t}^{(k)}<T_m\right)\ \cup\ \left(\forall j,\ Y_{j,t}^{(k)}<T_n\right).
\]
\end{lemma}

\begin{proof}
($\Rightarrow$) If there exists a block $(i,j)$ such that $X_{i,t}^{(k)}\ge T_m$ and
$Y_{j,t}^{(k)}\ge T_n$, then clearly $\exists i$ and $\exists j$ satisfying the row/col conditions.

($\Leftarrow$) If $\exists i^\star$ with $X_{i^\star,t}^{(k)}\ge T_m$ and $\exists j^\star$ with
$Y_{j^\star,t}^{(k)}\ge T_n$, then in block $(i^\star,j^\star)$, the co-cluster portion equals
$(R_k\cap I_{i^\star}^{(t)})\times (C_k^{\mathrm{col}}\cap J_{j^\star}^{(t)})$,
which has at least $T_m$ rows and $T_n$ columns. Hence co-cluster $k$ is captured.

Taking complements yields the stated miss event.
\end{proof}

这一条是你原推导最大结构性缺失：你不需要对 m\times n 做乘积；正确逻辑是“行侧存在 AND 列侧存在”。

⸻

B6. Theorem 1（修正）：单次 trial miss 概率上界（给你两个版本：严格版 + 紧版）

版本 A：严格自洽（无需 block 间独立/负相关）

\begin{theorem}[Single-trial miss bound (fully self-contained)]
\label{thm:single-trial-miss-selfcontained}
Fix $k$ and a trial $t$. Let
\[
p_{\mathrm{row}}^{(k)} := \min_{i\in[m]} \Pr(X_{i,t}^{(k)}<T_m),
\qquad
p_{\mathrm{col}}^{(k)} := \min_{j\in[n]} \Pr(Y_{j,t}^{(k)}<T_n).
\]
Then
\begin{equation}
\Pr(F_{k,t})
\le p_{\mathrm{row}}^{(k)} + p_{\mathrm{col}}^{(k)}.
\label{eq:trial-miss-selfcontained}
\end{equation}
Moreover, by Lemma~\ref{lem:hyp-tail},
\[
p_{\mathrm{row}}^{(k)} \le \exp\!\left(-2\max_i \phi_i (s_i^{(k)})^2\right),
\quad
p_{\mathrm{col}}^{(k)} \le \exp\!\left(-2\max_j \psi_j (t_j^{(k)})^2\right).
\]
\end{theorem}

\begin{proof}
By Lemma~\ref{lem:trial-equivalence},
\[
F_{k,t} = \Big(\bigcap_{i=1}^m \{X_{i,t}^{(k)}<T_m\}\Big)\ \cup\
\Big(\bigcap_{j=1}^n \{Y_{j,t}^{(k)}<T_n\}\Big).
\]
Using the union bound,
\[
\Pr(F_{k,t})\le
\Pr\Big(\bigcap_i \{X_{i,t}^{(k)}<T_m\}\Big)+
\Pr\Big(\bigcap_j \{Y_{j,t}^{(k)}<T_n\}\Big).
\]
For the first term, note that $\cap_i E_i \subseteq E_{i^\star}$ for any fixed $i^\star$,
thus $\Pr(\cap_i E_i)\le \Pr(E_{i^\star})$. Minimizing over $i^\star$ yields
\[
\Pr\Big(\bigcap_i \{X_{i,t}^{(k)}<T_m\}\Big)\le \min_i \Pr(X_{i,t}^{(k)}<T_m)=p_{\mathrm{row}}^{(k)}.
\]
Similarly for columns. This proves \eqref{eq:trial-miss-selfcontained}.
The exponential bounds follow from Lemma~\ref{lem:hyp-tail}.
\end{proof}

版本 B：更紧（用“负相关/负关联”得到你想要的“指数里出现求和”）

这版能恢复你原来风格，但注意：它用到一个标准结论（可引用）。

\begin{assumption}[Negative association across blocks (standard for multivariate hypergeometric)]
\label{assump:NA}
The vector $(X_{1,t}^{(k)},\dots,X_{m,t}^{(k)})$ induced by random permutation partitioning
is negatively associated. Hence for decreasing events $E_i$ depending on $X_{i,t}^{(k)}$,
\[
\Pr\Big(\bigcap_{i=1}^m E_i\Big)\le \prod_{i=1}^m \Pr(E_i).
\]
The same holds for $(Y_{1,t}^{(k)},\dots,Y_{n,t}^{(k)})$.
\end{assumption}

\begin{theorem}[Single-trial miss bound (tight form)]
\label{thm:single-trial-miss-tight}
Under Assumptions~\ref{assump:perm-partition}--\ref{assump:NA}, for each $k,t$ define
\[
\bar p_{\mathrm{row}}^{(k)} := \exp\!\left(-2\sum_{i=1}^m \phi_i (s_i^{(k)})^2\right),
\qquad
\bar p_{\mathrm{col}}^{(k)} := \exp\!\left(-2\sum_{j=1}^n \psi_j (t_j^{(k)})^2\right).
\]
Then the miss probability in a single trial satisfies
\begin{equation}
\Pr(F_{k,t})
\le \bar p_{\mathrm{row}}^{(k)} + \bar p_{\mathrm{col}}^{(k)}.
\label{eq:trial-miss-tight}
\end{equation}
\end{theorem}

\begin{proof}
By Lemma~\ref{lem:trial-equivalence} and the union bound,
\[
\Pr(F_{k,t})\le
\Pr\Big(\bigcap_{i=1}^m \{X_{i,t}^{(k)}<T_m\}\Big)+
\Pr\Big(\bigcap_{j=1}^n \{Y_{j,t}^{(k)}<T_n\}\Big).
\]
Under Assumption~\ref{assump:NA} and since $\{X_{i,t}^{(k)}<T_m\}$ are decreasing events,
\[
\Pr\Big(\bigcap_{i=1}^m \{X_{i,t}^{(k)}<T_m\}\Big)
\le \prod_{i=1}^m \Pr(X_{i,t}^{(k)}<T_m)
\le \prod_{i=1}^m \exp\!\left(-2\phi_i (s_i^{(k)})^2\right)
= \bar p_{\mathrm{row}}^{(k)}.
\]
Similarly,
$\Pr(\cap_j \{Y_{j,t}^{(k)}<T_n\})\le \bar p_{\mathrm{col}}^{(k)}$.
Combining gives \eqref{eq:trial-miss-tight}.
\end{proof}

你原来写的那种 \exp(-2(\text{行}+ \text{列})) 属于把 OR 错写成 AND 才能得到的“过强界”。这里的正确结构就是 “行失败概率 + 列失败概率”（或者精确式 p_{\mathrm{row}}+p_{\mathrm{col}}-p_{\mathrm{row}}p_{\mathrm{col}}）。

⸻

B7. Theorem 2（修正）：T_p 次试验 + K 个 co-clusters 的整体检测概率（完整证明）

\begin{theorem}[Probability of detecting all co-clusters over $T_p$ trials (revised)]
\label{thm:detect-all-revised}
Assume trials are independent (Assumption~\ref{assump:trial-indep}).
For each co-cluster $k$, let $q_k := \Pr(F_{k,t})$ be the single-trial miss probability
(which is trial-invariant by identical distribution).
Then the probability of detecting all $K$ co-clusters in at least one of the $T_p$ trials satisfies
\begin{equation}
p_{\mathrm{det}}(\text{all}) \ge 1 - \sum_{k=1}^K q_k^{T_p}
\ge 1 - K\cdot q_{\max}^{T_p},
\qquad q_{\max}:=\max_{k\in[K]} q_k.
\label{eq:detect-all-general}
\end{equation}
Equivalently, letting $\gamma_k := -\log q_k$ and $\gamma_{\min}:=\min_k \gamma_k$,
\begin{equation}
p_{\mathrm{det}}(\text{all}) \ge 1 - K \exp(-\gamma_{\min} T_p).
\label{eq:detect-all-exp}
\end{equation}

Moreover, plugging Theorem~\ref{thm:single-trial-miss-selfcontained} or
Theorem~\ref{thm:single-trial-miss-tight} yields explicit computable bounds on $q_k$.
\end{theorem}

\begin{proof}
For a fixed $k$, define the event $A_{k,t}:=\{\text{co-cluster }k\text{ is missed in trial }t\}$.
Then $\Pr(A_{k,t})=q_k$, and by independence across trials,
\[
\Pr(\text{miss }k\text{ in all }T_p\text{ trials})
=\Pr\Big(\bigcap_{t=1}^{T_p} A_{k,t}\Big)=\prod_{t=1}^{T_p}\Pr(A_{k,t})=q_k^{T_p}.
\]
Let $B$ be the event ``miss at least one co-cluster over all trials''.
Then
\[
B=\bigcup_{k=1}^K \{\text{miss }k\text{ in all }T_p\text{ trials}\}.
\]
Applying the union bound,
\[
\Pr(B)\le \sum_{k=1}^K q_k^{T_p}\le K q_{\max}^{T_p}.
\]
Therefore,
\[
p_{\mathrm{det}}(\text{all}) = 1-\Pr(B)\ge 1-\sum_{k=1}^K q_k^{T_p}\ge 1-Kq_{\max}^{T_p}.
\]
Writing $q_{\max}^{T_p}=\exp(-(-\log q_{\max})T_p)$ gives \eqref{eq:detect-all-exp}.
\end{proof}


⸻

B8. 统一块大小的化简式（对应你原来的 Eq.(prob-of-identifying-all-co-clusters)）

假设 \phi_i=\phi=M/m，\psi_j=\psi=N/n，并且 s_i^{(k)}\approx s^{(k)}，t_j^{(k)}\approx t^{(k)}。
用紧版 Theorem（指数求和）会得到：

\bar p_{\mathrm{row}}^{(k)}=\exp(-2m\phi (s^{(k)})^2)=\exp(-2M(s^{(k)})^2),
\bar p_{\mathrm{col}}^{(k)}=\exp(-2n\psi (t^{(k)})^2)=\exp(-2N(t^{(k)})^2).

因此单次 trial miss 上界是：
q_k \le \exp(-2M(s^{(k)})^2) + \exp(-2N(t^{(k)})^2).

于是整体检测概率（替换你原来的 \exp(-2T_p[M s^2 + N t^2]) 那条过强式子）是：

\begin{corollary}[Uniform block sizes]
\label{cor:uniform}
Under uniform block sizes $\phi=M/m$, $\psi=N/n$, Theorem~\ref{thm:single-trial-miss-tight} gives
\[
q_k \le \exp(-2M(s^{(k)})^2) + \exp(-2N(t^{(k)})^2),
\]
and Theorem~\ref{thm:detect-all-revised} yields
\[
p_{\mathrm{det}}(\text{all}) \ge 1 - K\left[\exp(-2M(s^{(k)})^2)+\exp(-2N(t^{(k)})^2)\right]^{T_p}.
\]
\end{corollary}

这一步是你原论文里必须改的：正确结构必然是 “指数项相加”，而不是 “指数里把行列贡献相加”。

⸻

B9. 如何选 T_p 保证 1-\alpha 成功率（可直接写到正文/算法里）

从 \eqref{eq:detect-all-general}：
K q_{\max}^{T_p}\le \alpha
\quad\Rightarrow\quad
T_p \ge \frac{\log(K/\alpha)}{-\log q_{\max}}.

如果你用 tight 版本并用上界 q_k\le \bar p_{\mathrm{row}}^{(k)}+\bar p_{\mathrm{col}}^{(k)}，那么
q_{\max}\le \max_k\left(\bar p_{\mathrm{row}}^{(k)}+\bar p_{\mathrm{col}}^{(k)}\right),
代入即可得到“可计算/可控”的 T_p。

可直接粘贴：

\paragraph{Choosing $T_p$ for a target failure level $\alpha$.}
From Theorem~\ref{thm:detect-all-revised}, it suffices to ensure
$K q_{\max}^{T_p}\le \alpha$, i.e.
\[
T_p \ge \frac{\log(K/\alpha)}{-\log q_{\max}}.
\]
Using Theorem~\ref{thm:single-trial-miss-tight}, one may upper bound
$q_{\max}\le \max_k\left(\bar p_{\mathrm{row}}^{(k)}+\bar p_{\mathrm{col}}^{(k)}\right)$,
leading to an explicit computable choice of $T_p$.


⸻

C. 你原算法/文字需要同步改动的地方（否则会被说“理论和算法不一致”）

C1. Algorithm 1/2 里“先知道 C_k 再算概率”是循环依赖

你现在的 Algorithm 里把 \{C_k\} 当输入/可计算量，这是不现实的。

修正建议（两种可选，写进算法说明即可）：
	1.	最坏情形设计：只保证对满足某个下界的 co-cluster（如 M^{(k)}\ge M_{\min}、N^{(k)}\ge N_{\min}）有效，用这些下界代入 s_i^{(k)},t_j^{(k)} 计算 T_p。
	2.	pilot sampling 估计：先用很小的 sample/sketch 估计潜在 co-cluster 尺寸分布（或估计 M^{(k)}/M、N^{(k)}/N 的下分位数），再设置 T_p。

这样你的理论链条是：给定“显著 cluster 的规模下界”→ 选参数 → 保证概率，不会循环。

⸻

D. 合并（merging）部分要补的一句“disjoint/partition”前提（否则 Lemma 7 不严谨）

你合并 Lemma（\Delta J 的闭式）写的是 disjoint co-clusters，但你实现描述里又用 overlap/Jaccard 去找候选对——这不矛盾，但你必须明确：

你的优化目标 J(\mathcal C) 是在“每个元素只属于一个 co-cluster”的划分上定义的。
overlap 仅用于候选筛选；真正合并前要先对重叠单元做唯一归属（tie-break 或 reassign），保证集合 disjoint。

建议你在 merging 理论开头补一句（可直接粘贴）：

\paragraph{Disjointness convention.}
Throughout the merging analysis, $\Cset$ is assumed to be a partition of matrix entries,
i.e., each $(i,j)$ belongs to exactly one co-cluster. Overlap-based heuristics are used only
to generate candidate pairs; before evaluating $\Delta J$, overlapping entries are assigned
to a unique cluster to maintain the partition property.

这样你后面的 merge-cost、单调下降、终止性证明就完全稳了。

⸻

E. 你原来的两个“必改公式”（给你明确替换）

E1. 原正文那条（过强/错误）：

你原来有类似：
P \ge 1-\exp\{-2T_p[M(s^{(k)})^2+N(t^{(k)})^2]\}
这是由 OR→AND 误替换造成的不成立下界。

E2. 正确替换（推荐写法）：

写成（tight 且解释清楚）：
p_{\mathrm{det}}(\text{all})
\ge 1-K\cdot q_{\max}^{T_p},\qquad
q_{\max}\le \max_k\left(\bar p_{\mathrm{row}}^{(k)}+\bar p_{\mathrm{col}}^{(k)}\right),
并在统一块大小下给出：
q_k \le e^{-2M(s^{(k)})^2}+e^{-2N(t^{(k)})^2}.

⸻

F. 你会得到什么结论层面的变化？
	•	你的“随 T_p 指数衰减”主叙事 保留，而且更严谨：
p_{\mathrm{det}}(\text{all}) \ge 1-K\exp(-\gamma_{\min}T_p).
	•	但 \gamma_{\min} 的具体形式不再是你原来“行列贡献在指数里相加”的过强版本，而是来自：
	•	单次 trial miss 概率 q_k 的正确上界（行失败 + 列失败）
	•	或其 log-sum-exp 形式 \gamma_k=-\log q_k

这是必须接受的代价：因为 miss 事件本质就是 OR，数学上不可能凭空变成 AND。

⸻
