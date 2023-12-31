#!/bin/bash

export PYTHONPATH="$(pwd)"

fixed_arc="4 3 1 3 1 1 2 1 0 1 0 0 0 0 0 0 0 0 0 0 0 5 0 1 1 1 0 0 5 1 0 0 1 1 0 0 3
 1 0 0 0 1 1 0 1 1 1 1 0 1 1 0 0 1 1 2 1 0 0 1 0 1 0 1 1 1 3 0 0 0 0 0 0 0
 0 1 0 1"


python2 src/cifar100/main.py \
python2 src/cifar100/general_child.py\
  --data_format="NCHW" \
  --search_for="macro" \
  --reset_output_dir \
  --data_path="data/cifar100" \
  --output_dir="outputs/final" \
  --batch_size=100 \
  --num_epochs=310 \
  --log_every=50 \
  --eval_every_epochs=1 \
  --child_fixed_arc="${fixed_arc}" \
  --child_use_aux_heads \
  --child_num_layers=12 \
  --child_out_filters=256 \
  --dataset="cifar100" \
  --child_l2_reg=2e-4 \
  --child_num_branches=7 \
  --child_num_cell_layers=5 \
  --child_keep_prob=0.50 \
  --child_lr_cosine \
  --child_lr_max=0.05 \
  --child_lr_min=0.001 \
  --child_lr_T_0=10 \
  --child_lr_T_mul=2 \
  --nocontroller_training \
  --controller_search_whole_channels \
  --controller_entropy_weight=0.0001 \
  --controller_train_every=1 \
  --controller_sync_replicas \
  --controller_num_aggregate=20 \
  --controller_train_steps=50 \
  --controller_lr=0.001 \
  --controller_tanh_constant=1.5 \
  --controller_op_tanh_reduce=2.5 \
  --controller_skip_target=0.4 \
  --controller_skip_weight=0.8 \
  --child_fr_fixed="2 4 6" \
  "$@"

