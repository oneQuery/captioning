import torch
from PIL import Image
from lavis.models import load_model_and_preprocess

# Setup device to use
device = torch.device("cuda" if torch.cuda.is_available() else "cpu")

# Load sample image
raw_image = Image.open("merlion.png").convert("RGB")

# Loads BLIP caption base model, with finetuned checkpoints on MSCOCO captioning dataset.
# This also loads the associated image processors
model, vis_processors, _ = load_model_and_preprocess(name="blip_caption", model_type="base_coco", is_eval=True, device=device)

# Preprocess the image
# vis_processors stores image transforms for "train" and "eval" (validation / testing / inference)
image = vis_processors["eval"](raw_image).unsqueeze(0).to(device)

# Generate caption
caption = model.generate({"image": image})
print(caption)
# ['a large fountain spewing water into the air']

# Show the image (moved to the end)
raw_image.show()
