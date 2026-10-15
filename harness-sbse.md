# Harness engineering: lessons from search-based software engineering

*Working notes — 15 October 2026*

Coding-agent harnesses often implement a search loop: propose a change, evaluate it with tests or other feedback, retain or reject it, and try again. That is recognisably related to **search-based software engineering (SBSE)**. Not every agent workflow is an explicit optimiser, and the analogy does not imply that the problems are solved.

These notes separate established search ideas, practical hypotheses for coding agents, and questions that still need evidence.

## The useful translation

| Observed harness problem | SBSE lens | Intervention worth testing | What remains uncertain |
| --- | --- | --- | --- |
| Repeated small patches without structural progress | Local optima; neighbourhood design | Detect stagnation; restart or perturb; change edit granularity | Which stagnation signals predict genuine architectural blockage? |
| All tests pass but the code gets harder to change | Fitness specification; multi-objective search | Track change cost and structural indicators alongside correctness | Which proxies predict future maintenance cost rather than just rewarding neat-looking code? |
| Multiple agents reach similar solutions | Premature convergence; diversity | Compare structurally distinct plans, not just independently sampled responses | How should architectural diversity be measured? |
| Success on known tests but failure on new requirements | Overfitting; generalisation | Hidden tests, mutation testing, holdout tasks, follow-on change tasks | What evaluation predicts performance on future work? |
| A needed refactor cannot be made in one passing step | Representation and search operators | Allow isolated branches with temporarily failing intermediate states, then validate the final state | How should the harness budget and safely manage these excursions? |
| Tests and model calls dominate runtime | Expensive fitness evaluation | Cheap checks first; selective full-suite runs; budget-aware search | When does screening discard the best candidates? |

## One observation from my own harness

My harness makes small changes and merges them only when every test passes. It works well for incremental work, but when a feature needs a structural change, the agent can spend a long time patching around the existing architecture.

My current intervention is to stop, make or request a larger structural change, tolerate the temporary breakage in an isolated working branch, then restart the harness to repair failures with small passing tasks. Rewriting a repeatedly failing task also works better than simply retrying it.

This resembles **perturbation followed by local search**. It is an observation, not yet a controlled result.

## Five experiments

1. **Stagnation:** Run comparable tasks with repeated retries versus restart, changed instructions, and larger perturbations. Measure success, time, tokens, and edit size.
2. **Architecture:** Give each approach a sequence of follow-on feature requests. Measure total time and regressions, not only the first task's completion.
3. **Temporary breakage:** Compare always-green incremental edits with an isolated branch that permits failing intermediate states but requires a green final merge.
4. **Diversity:** Compare several independent agents with agents explicitly required to propose different structural approaches. Inspect actual solution diversity and outcomes.
5. **Generalisation:** Evaluate on unseen tests and later maintenance tasks; check whether scores on visible tests predict either.

Control for model, budget, repository, task difficulty and evaluation harness. Report negative results. Avoid treating a proxy metric as the objective itself.

## Open questions

- What is a useful, hard-to-game measure of architectural quality or future cost of change?
- Can we detect a local optimum before wasting a large number of iterations?
- What search representation allows coherent cross-file, cross-component refactors?
- When is a larger architectural jump worth the extra risk and validation cost?
- Which classic SBSE techniques transfer to stochastic, language-driven agents, and which do not?

## Starting points for a literature review

These are starting points, **not** claims that each technique has been validated for LLM coding agents.

- Harman and Jones, *Search-Based Software Engineering* (2001), foundational framing.
- McMinn, *Search-Based Software Test Data Generation: A Survey* (2004), fitness and test generation.
- Deb et al., *A Fast and Elitist Multiobjective Genetic Algorithm: NSGA-II* (2002), multi-objective optimisation.
- Fraser and Arcuri, *EvoSuite: Automatic Test Suite Generation for Object-Oriented Software* (2011), automated test generation.

Related Substrate notes: [Harness engineering glossary](https://sub.xiliary.com/p/brendancodykenny/posts/71/i-made-a-harness-engineering-glossary-with-cross-field-names) and [Learnings from harness engineering](https://sub.xiliary.com/p/brendancodykenny/posts/70/learnings-from-harness-engineering).

The point is not to rename harness engineering as SBSE. It is to find out which decades-old lessons save us from repeating the same mistakes.
