## ROCm & AMD GPU Setup

The notebook should explicitly demonstrate that local inference is running on the AMD GPU using **ROCm**. This is an important part of the demonstration, as it highlights efficient utilization of AMD hardware instead of relying solely on external APIs.

### Objectives

* Verify that the notebook has access to an AMD GPU.
* Confirm that ROCm is installed correctly.
* Verify that PyTorch is using the ROCm backend.
* Run all local LLM inference on the AMD GPU.
* Use Fireworks AI only when additional reasoning is required.

### Supported Software Stack

```text
AMD GPU
    │
    ▼
ROCm Runtime
    │
    ▼
PyTorch (ROCm Build)
    │
    ▼
HuggingFace Transformers
    │
    ▼
Local LLM
```

Recommended libraries

* PyTorch (ROCm build)
* Transformers
* Accelerate
* Sentence Transformers

If supported by the notebook image, vLLM may also be evaluated for faster inference, but the primary implementation should use **PyTorch + Transformers** for maximum compatibility.

---

### GPU Verification

The notebook should verify that an AMD GPU is available before loading any models.

Checks to perform

* Display ROCm version
* Display GPU information
* Verify PyTorch GPU availability
* Display available VRAM
* Print detected device name

Expected output

```text
AMD GPU Detected

GPU Name:
AMD Instinct ...

ROCm Version:
...

Torch CUDA Available:
True

Device:
cuda:0
```

Although PyTorch exposes the device through the `torch.cuda` API, this is expected behavior on ROCm-enabled builds and indicates that inference is running on the AMD GPU.

If an AMD GPU is unavailable, the notebook should display a warning and gracefully fall back to CPU execution without crashing.

---

### Local Model Configuration

The notebook should load a lightweight instruct model directly onto the AMD GPU.

Recommended models

1. Qwen 2.5 3B Instruct
2. Llama 3.2 3B
3. Phi-4 Mini

Recommended loading configuration

* `device_map="auto"`
* `torch_dtype=torch.float16`
* Use `bfloat16` if supported by the hardware.

Expected output

```text
✓ Local Model Loaded

Inference Device:
AMD GPU

Precision:
float16

Memory Allocated:
...
```

---

### Why ROCm Is Used

The notebook intentionally performs the majority of inference locally using ROCm.

Benefits include

* Demonstrates native AMD GPU acceleration.
* Reduces dependence on external inference APIs.
* Decreases latency for common infrastructure incidents.
* Reduces operational cost.
* Showcases efficient hybrid AI architecture.

The local model should handle most diagnosis tasks, while Fireworks AI serves as a specialized reasoning engine for only the most complex or low-confidence incidents.

---

### Hybrid Inference Strategy

```text
Infrastructure Logs
        │
        ▼
Rule Engine
        │
        ▼
RAG Retrieval
        │
        ▼
Local LLM (ROCm / AMD GPU)
        │
        ▼
Confidence Evaluation
      ┌───────────────┐
      │               │
 High Confidence   Low Confidence
      │               │
      ▼               ▼
 Return        Fireworks AI
```

This architecture demonstrates intelligent resource utilization by leveraging AMD GPU acceleration for routine inference while minimizing external API usage.

---

### Performance Demonstration

Towards the end of the notebook, benchmark the local ROCm pipeline.

Suggested metrics

* Local inference latency
* GPU memory usage
* Model loading time
* Number of Fireworks API calls
* Percentage of requests resolved locally
* End-to-end diagnosis time

This section should clearly demonstrate that the majority of infrastructure incidents are diagnosed locally on the AMD GPU, with Fireworks AI invoked only when additional reasoning is required.

