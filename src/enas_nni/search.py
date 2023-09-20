# Copyright (c) Microsoft Corporation.
# Licensed under the MIT license.


from tensorflow.keras.losses import Reduction, SparseCategoricalCrossentropy
from tensorflow.keras.optimizers import SGD

# from nni.algorithms.nas.tensorflow import enas
from trainer import EnasTrainer

import datasets
from macro import GeneralNetwork
from micro import MicroNetwork
from utils import accuracy, accuracy_metrics


# TODO: argparse


dataset_train, dataset_valid = datasets.get_dataset()
# model = GeneralNetwork()
model = MicroNetwork()

loss = SparseCategoricalCrossentropy(from_logits=True, reduction=Reduction.NONE)
optimizer = SGD(learning_rate=0.05, momentum=0.9)

trainer = EnasTrainer(model,
                           loss=loss,
                           metrics=accuracy_metrics,
                           reward_function=accuracy,
                           optimizer=optimizer,
                           batch_size=64,
                           num_epochs=310,
                           dataset_train=dataset_train,
                           dataset_valid=dataset_valid)
trainer.train()
