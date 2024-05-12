#This script is an adapted version from the original TensorFlow tutorial:
#https://www.tensorflow.org/tutorials/distribute/keras
#The original tutorial (2022) TensorFlow.org, is under the terms of Apache2.0 licence:
#(https://www.apache.org/licenses/LICENSE-2.0)
#Access the address above for reading the text of the license.

###--- Initial setup
import tensorflow_datasets as tfds
import tensorflow as tf
import os
from tensorflow.python.client import device_lib
#UUU#from tensorflow.keras.datasets import mnist
# Load the TensorBoard notebook extension.
#AEG#%load_ext tensorboard

###--- Check number of available gpus:
print(device_lib.list_local_devices())

###--- Download the dataset
datasets, info = tfds.load(name='mnist', with_info=True, as_supervised=True)
mnist_train, mnist_test = datasets['train'], datasets['test']
#UUU#mnist_train, mnist_test = mnist.load_data()

###--- Define the distribution strategy
strategy = tf.distribute.MirroredStrategy()
print('Number of devices: {}'.format(strategy.num_replicas_in_sync))

###--- Set up the input pipeline
# You can also do info.splits.total_num_examples to get the total
# number of examples in the dataset.
num_train_examples = info.splits['train'].num_examples
num_test_examples = info.splits['test'].num_examples
BUFFER_SIZE = 10000
BATCH_SIZE_PER_REPLICA = 64
BATCH_SIZE = BATCH_SIZE_PER_REPLICA * strategy.num_replicas_in_sync

def scale(image, label):
   image = tf.cast(image, tf.float32)
   image /= 255
   return image, label

train_dataset = mnist_train.map(scale).cache().shuffle(BUFFER_SIZE).batch(BATCH_SIZE)
eval_dataset = mnist_test.map(scale).batch(BATCH_SIZE)

###--- Create the model
with strategy.scope():
   model = tf.keras.Sequential([
           tf.keras.layers.Conv2D(32, 3, activation='relu', input_shape=(28, 28, 1)),
           tf.keras.layers.MaxPooling2D(),
           tf.keras.layers.Flatten(),
           tf.keras.layers.Dense(64, activation='relu'),
           tf.keras.layers.Dense(10)
   ])

   model.compile(loss=tf.keras.losses.SparseCategoricalCrossentropy(from_logits=True),
                 optimizer=tf.keras.optimizers.Adam(),
                 metrics=['accuracy'])

###--- Define callbacks
# Define the checkpoint directory to store the checkpoints.
checkpoint_dir = './training_checkpoints'
# Define the name of the checkpoint files.
checkpoint_prefix = os.path.join(checkpoint_dir, "ckpt_{epoch}")

# Define a function for decaying the learning rate.
# You can define any decay function you need.
def decay(epoch):
   if epoch < 3:
      return 1e-3
   elif epoch >= 3 and epoch < 7:
      return 1e-4
   else:
      return 1e-5

# Define a callback for printing the learning rate at the end of each epoch.
class PrintLR(tf.keras.callbacks.Callback):
   def on_epoch_end(self, epoch, logs=None):
      print('\nLearning rate for epoch {} is {}'.format(        epoch + 1, model.optimizer.lr.numpy()))

# Put all the callbacks together.
callbacks = [
    tf.keras.callbacks.TensorBoard(log_dir='./logs'),
    tf.keras.callbacks.ModelCheckpoint(filepath=checkpoint_prefix,
                                       save_weights_only=True),
    tf.keras.callbacks.LearningRateScheduler(decay),
    PrintLR()
]

###--- Train and evaluate
# Train
EPOCHS = 12
model.fit(train_dataset, epochs=EPOCHS, callbacks=callbacks)

# Check the checkpoint directory.
print('Listing the content of the checkpoint_dir')
print(os.listdir(checkpoint_dir))

# Evaluate
model.load_weights(tf.train.latest_checkpoint(checkpoint_dir))
eval_loss, eval_acc = model.evaluate(eval_dataset)
print('Eval loss: {}, Eval accuracy: {}'.format(eval_loss, eval_acc))

###--- Export to SavedModel
save_dir = 'saved_model/'
model.save(save_dir, save_format='tf')

###--- Now, load the SavedModel
unreplicated_model = tf.keras.models.load_model(save_dir)

unreplicated_model.compile(
    loss=tf.keras.losses.SparseCategoricalCrossentropy(from_logits=True),
    optimizer=tf.keras.optimizers.Adam(),
    metrics=['accuracy'])

eval_loss, eval_acc = unreplicated_model.evaluate(eval_dataset)

print('Saved Eval Loss: {}, Saved Eval Accuracy: {}'.format(eval_loss, eval_acc))

