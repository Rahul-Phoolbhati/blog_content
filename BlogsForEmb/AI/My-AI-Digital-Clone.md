---
layout: default
title: Making your digital AI clone
---

Making your digital AI clone — Reply your WhatsApp chat like you do
===================================================================
> **_Can an AI reply exactly like I would?_**
> 
> _I wanted to find out._

One day while using WhatsApp the lazy me thought to build **my clone** — one that understands my texting style, the phrases I frequently use, my shorthand, and even my personality while chatting with someone.

Fine tuning Qwen or Gemma model on my exported WhatsApp conversations with a specific person was the way I found. The result is a model that can generate replies that closely resemble how I usually respond ( odd replier ).

The Idea
--------

Most AI assistants are trained to sound helpful and professional.

But none of them text exactly like _me_.

The unique way of chatting:

*   favorite phrases
*   abbreviations
*   sentence length
*   humor
*   response patterns
*   texting habits

So I wondered:

> **_Can a Small Language Model learn my texting personality?_**

Turns out…

Yes (kinda similar , but needs improvement).

What I needed
-------------

*   **Google Colab**
*   **Qwen2.5–7B-Instruct**
*   **Unsloth**
*   **LoRA Fine-tuning**
*   WhatsApp Chat Export
*   Python

Dataset
-------

The training data came from an exported WhatsApp chat with one person.

Instead of training on general conversations, I only wanted the model to learn **how I reply**.

So I converted the conversation into instruction-style samples.

Example:

```
### InputThem:
Aa rha h kl?### OutputMe:
Yeah probably 😂
Btata hu me, ruk.
```

Each example teaches the model:

*   what the other person said
*   how I actually responded

Over thousands of messages, the model starts learning my style.

Data Cleaning
-------------

Raw WhatsApp exports contain lots of noise.

Some preprocessing included:

*   removing timestamps
*   removing system messages
*   merging multiline texts (continuous replies)
*   separating sender and receiver
*   creating prompt-response pairs

Clean data. Although WhatsApp don’t give you the message tagged in a particular reply in export and it creates a lot noisy training as well — a definite impact. But thought let’s first go ahead.

Why Qwen 2.5 SLM?
-----------------

I wanted something:

*   lightweight
*   fast
*   affordable to train (on Colab free GPU)
*   capable of conversational tasks

Qwen 2.5 SLM was a perfect fit because it performs surprisingly well despite its size.

Smaller models are also much easier to fine-tune on Google Colab.

Why Unsloth?
------------

Training LLMs normally requires a lot of GPU memory.

Unsloth makes fine-tuning significantly easier by:

*   reducing VRAM usage
*   speeding up training
*   integrating with Hugging Face
*   supporting LoRA out of the box

That meant I could train everything on Google Colab without expensive hardware.

Fine-Tuning
-----------

I used LoRA fine-tuning instead of updating every model parameter.

This makes training:

*   faster
*   cheaper
*   memory efficient

Only a small number of parameters are trained while the original model stays mostly frozen.

The Workflow
------------

```
WhatsApp Export
        │
        ▼
Clean Dataset
        │
        ▼
Prompt → Response Pairs
        │
        ▼
LoRA Fine-tuning (Unsloth)
        │
        ▼
Trained Adapter
        │
        ▼
Inference
```

Inference
---------

After training, using the model is simple.

Instead of giving a random prompt, I provide the latest message from the conversation.

Example:

```
### Input 
Them:
You forgot to reply 
```

The model generates something like:

```
Arrey sorry 😭
Got busy yaar.
What's up now?
```

Instead of sounding like ChatGPT, it sounds much closer to how I usually text.

What It Learned
---------------

The model gradually picked up things like:

*   my favourite words
*   common abbreviations
*   sentence structure
*   casual tone
*   how long my replies usually are

It doesn’t memorize every conversation.

Instead, it learns statistical patterns in how I communicate.

Limitations
-----------

This is **style transfer**, not personality transfer.

The model can imitate how I write.

It does **not**:

*   know my memories
*   know current events
*   know new conversations
*   perfectly recreate my thoughts

It’s still generating text based on learned patterns. Also

*   I might respond different people in different way, It’s learning only one of the personality , Giving all chat would have mixed things, finding the way for it also.
*   Some times, due to shorthands it creates sentence from word which don’t have a nice meaning or where word don’t fit , probably due to less data of a single chat and hinglish and my own typing mistakes in the data as well.

Thanks for reading!
-------------------
