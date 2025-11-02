from PIL import ImageFont


def getsize(font: ImageFont, text: str) -> tuple[int, int]:
    """Get text size in pixels.

    Utility function to replace ImageFont.getsize removed from Pillow>=10
    """
    left, top, right, bottom = font.getbbox(text)
    width = right - left
    height = bottom - top
    return width, height
