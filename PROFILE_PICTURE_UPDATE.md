# How to Update Your Profile Picture

## Current Profile Picture Location
Your profile picture is located at: `assets/img/prof_pic.jpg`

This image is referenced in the file `_pages/about.md` on line 9.

## How to Update the Profile Picture

### Option 1: Upload via GitHub Mobile App (Recommended for Mobile)

1. **Install the GitHub Mobile App**
   - Download from the [App Store (iOS)](https://apps.apple.com/app/github/id1477376905) or [Google Play (Android)](https://play.google.com/store/apps/details?id=com.github.android)
   - Sign in to your GitHub account

2. **Navigate to Your Repository**
   - Open the app and go to your repository: `sande570/sande570.github.io`

3. **Upload the New Image**
   - Tap on the `assets` folder
   - Tap on the `img` folder
   - Tap the "+" button (or menu icon) at the top right
   - Select "Upload files"
   - Choose your new headshot image from your phone's photo library
   - **Important:** Name the file `prof_pic.jpg` (or replace the existing one)
   - Add a commit message like "Update profile picture"
   - Tap "Commit changes"

### Option 2: Upload via GitHub Website on Mobile Browser

1. **Open GitHub in Your Mobile Browser**
   - Go to https://github.com/sande570/sande570.github.io
   - Sign in if needed

2. **Navigate to the Images Folder**
   - Tap on `assets` folder
   - Tap on `img` folder

3. **Upload Your New Image**
   - Scroll down and tap "Add file" → "Upload files"
   - Tap "choose your files" and select your new headshot from your photo library
   - **Important:** Name it `prof_pic.jpg` to replace the existing one
   - Add a commit message like "Update profile picture"
   - Tap "Commit changes"

### Option 3: Desktop/Laptop (If Available)

1. **Navigate to the Repository**
   - Go to https://github.com/sande570/sande570.github.io

2. **Upload the Image**
   - Click on `assets` → `img`
   - Click "Add file" → "Upload files"
   - Drag and drop your image or click to browse
   - Name it `prof_pic.jpg`
   - Commit with message "Update profile picture"

## Important Notes

- **File Name:** The image must be named `prof_pic.jpg` to work automatically
- **Image Format:** JPG/JPEG is recommended (PNG also works, just update the filename in `_pages/about.md`)
- **Image Size:** For best results, use a square or portrait-oriented image. The site will automatically resize it.
- **Deployment:** After uploading, GitHub Pages will automatically rebuild your site (this may take 1-5 minutes)

## Alternative: Using a Different Filename

If you want to use a different filename (e.g., `my_new_headshot.png`):

1. Upload your image to `assets/img/` with your chosen filename
2. Edit the file `_pages/about.md`
3. Change line 9 from:
   ```yaml
   image: prof_pic.jpg
   ```
   to:
   ```yaml
   image: my_new_headshot.png
   ```
4. Commit the change

## Viewing Your Changes

After committing your new image:
1. Wait 1-5 minutes for GitHub Pages to rebuild
2. Visit your website: https://sande570.github.io
3. Refresh the page (you may need to do a hard refresh: Ctrl+Shift+R on desktop, or clear cache on mobile)
4. Your new profile picture should appear!

## Troubleshooting

- **Image not showing:** Make sure the filename matches exactly (case-sensitive)
- **Old image still showing:** Clear your browser cache or try incognito/private mode
- **Image looks stretched:** Try using a square image (e.g., 500x500 pixels)

## Current Image Info

- Main profile picture: `assets/img/prof_pic.jpg` (referenced in `_pages/about.md`)
- Alternative image exists: `assets/img/prof_pic_color.png` (not currently used)
