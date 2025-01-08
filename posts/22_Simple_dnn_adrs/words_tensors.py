# work-in-progress (may slowly evolve into a class code...)

import torch
import torch.nn as nn
from collections import Counter

torch.manual_seed(1)

def words_tensors(adr: str):
    
    words = adr.split(', ')
    vocab = Counter(words)
    vocab_size = len(vocab)
    word2idx = {word: ind for ind, word in enumerate(vocab)}
    encoded_adr = [word2idx[word] for word in words]
    # ?may need to make embedding_dim as an optional parameter
    embedding_dim = 2
    emb = nn.Embedding(vocab_size, embedding_dim)
    word_vectors = torch.LongTensor(encoded_adr)
    tensors = emb(word_vectors)

    return tensors