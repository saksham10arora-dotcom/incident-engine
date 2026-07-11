# AI Infrastructure Doctor - Hackathon Notebook Guide

## Overview

This notebook demonstrates an **AI-powered Infrastructure Doctor** capable of automatically diagnosing production infrastructure failures, identifying root causes, proposing fixes, and generating pull requests.

The notebook is designed to showcase:

* Efficient AMD GPU utilization for local inference
* Hybrid AI architecture (Rules + Local LLM + Fireworks AI)
* Enterprise DevOps workflow
* Retrieval-Augmented Generation (RAG)
* Automatic infrastructure remediation

The notebook should execute **top-to-bottom without modification**, producing a complete end-to-end demonstration.

---

# Overall Pipeline

```
Infrastructure Logs
        │
        ▼
Log Parser
        │
        ▼
Infrastructure Graph
        │
        ▼
Rule Engine
        │
        ▼
Document Retrieval (RAG)
        │
        ▼
Local LLM (AMD GPU)
        │
        ▼
Confidence Evaluation
      ┌──────────────┐
      │              │
 High Confidence   Low Confidence
      │              │
      ▼              ▼
 Return        Fireworks AI
      │              │
      └──────┬───────┘
             ▼
Root Cause Analysis
             ▼
Patch Generator
             ▼
Pull Request Generator
             ▼
Final Incident Report
```

---

# Notebook Structure

---

# Cell 1 — Project Introduction

## Purpose

Introduce the project.

### Output

Display

* Project name
* Problem statement
* Architecture diagram
* Technologies used

The notebook should clearly explain the motivation behind AI-assisted infrastructure debugging.

---

# Cell 2 — Install Dependencies

Install all required libraries.

Example categories

* Transformers
* PyTorch
* OpenAI SDK
* Sentence Transformers
* FAISS
* DuckDB
* Pandas
* Kubernetes SDK
* Docker SDK
* AWS SDK
* Azure SDK
* Tree-sitter
* NetworkX

### Output

```
✓ Dependencies Installed
```

---

# Cell 3 — Verify AMD GPU

Purpose

Confirm GPU availability.

Steps

* Print ROCm version
* Print GPU information
* Verify Torch GPU access

### Expected Output

```
AMD GPU Detected

GPU Name:
...

VRAM:
...

Torch CUDA Available:
True
```

If GPU is unavailable, display a warning while allowing CPU execution.

---

# Cell 4 — Configure Fireworks AI

Load

* API Key
* Base URL
* Allowed model

The notebook should read credentials from environment variables or notebook secrets.

Do not hardcode credentials.

### Output

```
✓ Fireworks Connected
```

---

# Cell 5 — Load Local Model

Load a lightweight instruct model onto the AMD GPU.

Suggested models

* Qwen 2.5 3B Instruct
* Llama 3.2 3B
* Phi-4 Mini

Model should load using

* float16
* bfloat16 (if available)
* device_map="auto"

### Output

```
✓ Local Model Loaded
Inference Device:
AMD GPU
```

---

# Cell 6 — Load Sample Incident Logs

Provide realistic production logs.

Include examples from

* Kubernetes
* Docker
* AWS CloudWatch
* Azure Monitor

### Output

Display

* Number of logs
* Source distribution
* First few log entries

---

# Cell 7 — Log Parsing

Convert raw logs into structured events.

Extract

* Timestamp
* Severity
* Service
* Pod
* Namespace
* Container
* Message
* Error Type

### Output

Display parsed dataframe.

---

# Cell 8 — Infrastructure Graph

Build a dependency graph.

Example

```
Frontend

↓

API

↓

Redis

↓

Postgres
```

Use NetworkX.

### Output

Visualize dependency graph.

---

# Cell 9 — Rule Engine

Detect deterministic failures.

Examples

* OOMKilled
* CrashLoopBackOff
* ImagePullBackOff
* DNS Failure
* TLS Failure
* Exit Code 137
* Authentication Error
* Missing Secret

Each rule should produce

* Issue
* Severity
* Confidence
* Evidence

### Output

Display detected incidents.

---

# Cell 10 — Build Knowledge Base

Create retrieval corpus.

Include documentation from

* Kubernetes
* Docker
* AWS
* Azure
* Internal Runbooks

Generate embeddings.

Store inside

* FAISS
* Chroma
* DuckDB

### Output

```
Knowledge Base Created

Documents:
XXX

Embeddings:
Generated
```

---

# Cell 11 — Retrieve Relevant Documentation

For each detected issue

Retrieve

Top-K relevant documents.

### Output

Display

* Retrieved passages
* Similarity score

---

# Cell 12 — Local AI Diagnosis

Input

* Parsed logs
* Rule engine output
* Retrieved documentation

The local model should produce

* Root cause
* Explanation
* Supporting evidence
* Recommended fix

### Output

```
Root Cause

...

Evidence

...

Recommendation

...
```

---

# Cell 13 — Confidence Evaluation

Evaluate confidence of the diagnosis.

Possible approaches

* Rule confidence
* LLM self-evaluation
* Retrieval relevance
* Agreement between rules and model

If confidence exceeds threshold

Return diagnosis.

Otherwise

Escalate to Fireworks AI.

### Output

```
Confidence

94%

Decision

Local Model Accepted
```

or

```
Confidence

62%

Escalating to Fireworks AI
```

---

# Cell 14 — Fireworks AI Analysis

Only executed when confidence is low.

Provide

* Logs
* Retrieved documentation
* Previous diagnosis

Fireworks performs deeper reasoning.

### Output

Enhanced diagnosis.

---

# Cell 15 — Patch Generator

Generate infrastructure fix.

Examples

* Kubernetes YAML
* Dockerfile
* Terraform
* GitHub Actions
* Helm values

Output should include

* Before
* After
* Explanation

---

# Cell 16 — Pull Request Generator

Automatically create PR description.

Generate

Title

Summary

Root Cause

Changes

Risk Assessment

Testing Instructions

### Output

Display complete PR.

---

# Cell 17 — Incident Timeline

Generate timeline.

Example

```
10:01 Deployment

↓

10:02 Image Pulled

↓

10:03 Health Check Failed

↓

10:04 Restart

↓

10:05 CrashLoop

↓

10:08 Alert Triggered
```

Visualize sequence of events.

---

# Cell 18 — Final Incident Report

Produce a professional report.

Include

* Incident Summary
* Root Cause
* Confidence
* Supporting Evidence
* Retrieved References
* Proposed Fix
* Patch
* Pull Request

### Output

One comprehensive report.

---

# Cell 19 — Multiple Incident Demonstrations

Run several independent examples.

Recommended scenarios

## Example 1

CrashLoopBackOff

---

## Example 2

OOMKilled

---

## Example 3

Redis unavailable

---

## Example 4

Expired TLS Certificate

---

## Example 5

AWS IAM Permission Failure

Each scenario should execute the complete pipeline.

---

# Cell 20 — Performance Metrics

Measure

* Local inference latency
* Fireworks latency
* GPU utilization
* Memory consumption
* Retrieval time
* Number of Fireworks API calls

### Output

Performance table.

---

# Cell 21 — Architecture Summary

Present the final architecture.

Explain

* Rule Engine
* Retrieval
* Local Model
* Fireworks Escalation
* Patch Generator
* PR Generator

This cell serves as the project overview for judges.

---

# Expected Folder Structure

```
project/

├── notebook.ipynb

├── data/
│   ├── kubernetes.log
│   ├── docker.log
│   ├── aws.log
│   ├── azure.log

├── docs/
│   ├── kubernetes_docs/
│   ├── docker_docs/
│   ├── aws_docs/
│   ├── azure_docs/

├── models/

├── embeddings/

├── patches/

├── reports/

└── requirements.txt
```

---

# Recommended Local Model

Use one lightweight instruct model that comfortably fits on the AMD GPU.

Recommended order

1. Qwen 2.5 3B Instruct
2. Llama 3.2 3B
3. Phi-4 Mini

---

# Fireworks AI Usage Strategy

Fireworks should **not** answer every request.

Instead

```
Logs
      │
      ▼
Rule Engine
      │
      ▼
Local Model
      │
      ▼
Confidence Check
      │
 ┌────┴────┐
 │         │
High      Low
 │         │
 ▼         ▼
Return  Fireworks AI
```

This demonstrates efficient resource utilization while reducing external API usage.

---

# Final Deliverable

At the end of the notebook, judges should observe the following complete workflow:

1. Production logs are uploaded.
2. Logs are parsed into structured events.
3. Infrastructure dependencies are reconstructed.
4. Deterministic rules identify obvious failures.
5. Relevant documentation is retrieved through RAG.
6. The local LLM performs root cause analysis on the AMD GPU.
7. Confidence is evaluated.
8. Fireworks AI is consulted only when deeper reasoning is required.
9. A corrected infrastructure configuration is generated.
10. A complete GitHub Pull Request is produced automatically.
11. A professional incident report summarizes the diagnosis, evidence, and remediation.

The notebook should execute from start to finish without manual intervention, clearly demonstrating an enterprise-ready autonomous Infrastructure Doctor capable of diagnosing, explaining, and remediating real-world DevOps incidents.

