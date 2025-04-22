    <!DOCTYPE html>
    <html lang="ko">

    <head>
        <meta charset="UTF-8">
        <title>상품 등록</title>
        <style>
            body {
                font-family: sans-serif;
                padding: 40px;
            }

            .container {
                display: flex;
                gap: 40px;
                align-items: flex-start;
                max-width: 1200px;
                margin: auto;
            }

            .left {
                flex: 1;
            }

            .main-image {
                width: 100%;
                aspect-ratio: 1 / 1;
                border: 1px solid #999;
                display: flex;
                align-items: center;
                justify-content: center;
                position: relative;
                box-shadow: 2px 2px 6px rgba(0, 0, 0, 0.1);
            }

            .add-image-btn {
                position: absolute;
                bottom: 10px;
                right: 10px;
                font-size: 12px;
                border: 1px solid #999;
                padding: 3px 8px;
                background: #f3f3f3;
                cursor: pointer;
            }

            .thumbnail-box {
        display: flex;
        gap: 10px;
        flex-wrap: wrap;
        margin-top: 10px;
        font-size: 13px;
        align-items: center;
    }


            .thumbnail-box div {
                width: 70px;
                height: 70px;
                border: 1px solid #999;
                box-shadow: 1px 1px 4px rgba(0, 0, 0, 0.1);
            }

            .right {
                flex: 1;
            }

            .form-box {
                border: 1px solid #999;
                padding: 20px;
                margin-bottom: 20px;
            }

            .form-box div {
                margin-bottom: 10px;
            }

            input,
            select {
                padding: 5px;
                box-sizing: border-box;
            }

            .category-row {
                display: flex;
                gap: 5px;
                align-items: center;
            }

            .category-row select {
                flex: 1;
            }

            .radio-group {
                margin: 20px 0;
                display: flex;
                gap: 20px;
                align-items: center;
            }

            .dynamic-options {
                margin-top: 20px;
            }

            .color-block {
                margin-bottom: 20px;
                border-bottom: 1px solid #ccc;
                padding-bottom: 10px;
            }

            .option-row {
                display: flex;
                gap: 10px;
                align-items: center;
                margin-bottom: 10px;
            }

            .option-row select,
            .option-row input {
                padding: 5px;
            }

            .option-row button {
                background: none;
                border: none;
                font-size: 16px;
                cursor: pointer;
                color: red;
            }

            .add-btn {
                display: inline-block;
                margin-top: 10px;
                padding: 5px 10px;
                background-color: #007BFF;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }

            .size-sublist {
                margin-left: 20px;
                margin-top: 10px;
            }
            .sub-thumbnails {
        display: flex;
        gap: 10px;
        margin-top: 10px;
        justify-content: center;
    }

    .sub-thumbnails {
        display: flex;
        gap: 10px;
        margin-top: 10px;
        justify-content: center;
    }

    .sub-thumb {
        width: 80px;
        height: 80px;
        border: 1px solid #999;
        box-shadow: 1px 1px 4px rgba(0, 0, 0, 0.1);
        position: relative;
        background-color: #f5f5f5;
        overflow: hidden;
    }

    .sub-thumb img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }

    .sub-thumb button {
        position: absolute;
        top: 2px;
        right: 2px;
        background: transparent;
        border: none;
        color: red;
        cursor: pointer;
        font-size: 13px;
        padding: 0;
    }
    .image-upload-section {
        margin-top: 80px;
        text-align: center;
    }

    .image-upload-section input[type="text"] {
        width: 300px;
        padding: 8px;
        font-size: 14px;
        margin-bottom: 20px;
    }

    .big-preview-box {
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: 20px;
        margin-bottom: 20px;
    }

    .big-img-slot {
    width: 400px;
    height: 400px;
    border: 2px solid #ccc;
    background-color: #fafafa;
    display: flex;
    align-items: center;
    justify-content: center;
    position: relative;
    overflow: hidden;
}

    .big-img-slot img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }

    .big-img-slot button {
        position: absolute;
        top: 4px;
        right: 4px;
        background: transparent;
        border: none;
        color: red;
        font-size: 16px;
        cursor: pointer;
    }
    .final-submit-section {
    text-align: center;
    margin-top: 60px;
}

.final-submit-section textarea {
    width: 80%;
    height: 150px;
    padding: 15px;
    font-size: 16px;
    resize: vertical;
    border: 1px solid #ccc;
    border-radius: 8px;
    margin-bottom: 20px;
}

.submit-btn {
    padding: 12px 30px;
    background-color: #28a745;
    color: white;
    font-size: 16px;
    border: none;
    border-radius: 6px;
    cursor: pointer;
}

.submit-btn:hover {
    background-color: #218838;
}
#bigImageTitle {
    width: 500px;
    height: 80px;
    padding: 10px;
    font-size: 15px;
    resize: vertical;
    border-radius: 6px;
    border: 1px solid #ccc;
}



        </style>
    </head>

    <body>
        <h2>상품등록</h2>
        <div class="container">
            <div class="left">
                <div class="main-image">
                    <span>이미지 영역</span>
                </div>
                <div class="sub-thumbnails">
                    <div class="sub-thumb"></div>
                    <div class="sub-thumb"></div>
                    <div class="sub-thumb"></div>
                </div>
                
                <div style="margin-top: 10px;">
                    <button id="addImageBtn" class="add-btn">+ 이미지 추가</button>
                </div>
                
                <div class="thumbnail-box" id="thumbnailBox"></div>
                <input type="file" id="imageInput" multiple accept="image/*" style="display:none">
            </div>
            

            <div class="right">
                <div class="form-box">
                    <div class="category-row">
                        <select>
                            <option>대분류</option>
                        </select>
                        <span> > </span>
                        <select>
                            <option>소분류</option>
                        </select>
                        <span style="margin-left: auto; font-size: 12px;">카테고리 선택</span>
                    </div>
                    <div><input type="text" placeholder="상품명 입력" style="width: 100%;"></div>
                    <div><input type="text" placeholder="제품코드 입력" style="width: 100%;"></div>
                    <div><input type="text" placeholder="원가 입력" style="width: 100%;"></div>
                    <div><input type="text" placeholder="판매가 입력" style="width: 100%;"></div>
                    <div><input type="text" placeholder="할인가 입력" style="width: 100%;"></div>
                </div>

                <div class="radio-group">
                    <span>분류:</span>
                    <label><input type="radio" name="type"> 신상품</label>
                    <label><input type="radio" name="type"> 인기상품</label>
                    <label><input type="radio" name="type"> 추천상품</label>
                </div>

                <div class="dynamic-options">
                    <div id="options-container"></div>
                </div>
                <div class="dynamic-options">
                    <div style="margin-bottom: 10px;">
                        <select id="colorSelector">
                            <option value="">색상 선택</option>
                            <option value="파랑">파랑</option>
                            <option value="빨강">빨강</option>
                            <option value="노랑">노랑</option>
                        </select>
                    </div>
                </div>

            </div>
        </div>
        <div class="image-upload-section">
            <div class="big-preview-box" id="bigPreviewBox"></div>
            <input type="file" id="bigImageInput" multiple accept="image/*" style="display:none">
            <button class="add-btn" id="bigImageUploadBtn">+ 이미지 등록</button><br>
            <input type="text" id="bigImageTitle" placeholder="제품 설명글 입력" />
            <div class="big-preview-box" id="sizeImageBox"></div>
            <input type="file" id="sizeImageInput" accept="image/*" style="display:none">
            <button class="add-btn" id="sizeImageUploadBtn">+ 사이즈 설명표 추가</button>
        </div>
        <div class="final-submit-section">
            <button class="submit-btn">등록하기</button>
        </div>
    </body>
    <script>
        const usedColors = new Set();
        const colorSelector = document.getElementById("colorSelector");
        const container = document.getElementById("options-container");
        const imageInput = document.getElementById('imageInput');
        const addImageBtn = document.getElementById('addImageBtn');
        const thumbnailBox = document.getElementById('thumbnailBox');
        let uploadedFiles = [];
        const bigImageInput = document.getElementById('bigImageInput');
    const bigImageUploadBtn = document.getElementById('bigImageUploadBtn');
    const bigPreviewBox = document.getElementById('bigPreviewBox');
    let bigImages = [];
    const sizeImageInput = document.getElementById('sizeImageInput');
const sizeImageUploadBtn = document.getElementById('sizeImageUploadBtn');
const sizeImageBox = document.getElementById('sizeImageBox');
let sizeImageFile = null;

sizeImageUploadBtn.addEventListener('click', () => {
    if (sizeImageFile) {
        alert("사이즈 설명표 이미지는 1장만 등록할 수 있습니다.");
        return;
    }
    sizeImageInput.click();
});

sizeImageInput.addEventListener('change', () => {
    const file = sizeImageInput.files[0];
    if (file) {
        sizeImageFile = file;
        displaySizeImage(file);
    }
    sizeImageInput.value = ''; // 초기화
});

function displaySizeImage(file) {
    const reader = new FileReader();
    reader.onload = (e) => {
        sizeImageBox.innerHTML = ''; // 기존 이미지 제거

        const slot = document.createElement('div');
        slot.className = 'big-img-slot';

        const img = document.createElement('img');
        img.src = e.target.result;

        const removeBtn = document.createElement('button');
        removeBtn.textContent = '✖';
        removeBtn.onclick = () => {
            sizeImageFile = null;
            sizeImageBox.innerHTML = '';
        };

        slot.appendChild(img);
        slot.appendChild(removeBtn);
        sizeImageBox.appendChild(slot);
    };
    reader.readAsDataURL(file);
}


    bigImageUploadBtn.addEventListener('click', () => {
        if (bigImages.length >= 4) {
            alert("최대 4장의 이미지만 등록할 수 있습니다.");
            return;
        }
        bigImageInput.click();
    });

    bigImageInput.addEventListener('change', () => {
        const files = Array.from(bigImageInput.files);
        const remaining = 4 - bigImages.length;

        files.slice(0, remaining).forEach(file => {
            bigImages.push(file);
            displayBigImage(file);
        });

        bigImageInput.value = '';
    });

        
        addImageBtn.addEventListener('click', () => {
            if (uploadedFiles.length >= 4) {
                alert("이미지는 최대 4장까지 업로드 가능합니다.");
                return;
            }
            imageInput.click();
        });
        
        imageInput.addEventListener('change', () => {
            const files = Array.from(imageInput.files);
            const availableSlots = 4 - uploadedFiles.length;
        
            files.slice(0, availableSlots).forEach(file => {
                uploadedFiles.push(file);
                displayThumbnail(file);
            });
        
            imageInput.value = '';
        });
        
        function displayThumbnail(file) {
            const reader = new FileReader();
            reader.onload = (e) => {
                const wrapper = document.createElement('span');
                wrapper.style.display = 'inline-flex';
                wrapper.style.alignItems = 'center';
        
                const filename = document.createElement('span');
                filename.textContent = file.name;
        
                const removeBtn = document.createElement('button');
                removeBtn.textContent = '✖';
                removeBtn.style.marginLeft = '4px';
                removeBtn.style.background = 'transparent';
                removeBtn.style.border = 'none';
                removeBtn.style.color = 'red';
                removeBtn.style.cursor = 'pointer';
                removeBtn.style.fontSize = '13px';
                removeBtn.style.padding = '0';
        
                removeBtn.addEventListener('click', () => {
                    uploadedFiles = uploadedFiles.filter(f => f !== file);
                    wrapper.remove();
        
                    const mainImageDiv = document.querySelector('.main-image');
                    if (uploadedFiles.length === 0) {
                        mainImageDiv.innerHTML = '<span>이미지 영역</span>';
                    } else if (file === uploadedFiles[0]) {
                        const newReader = new FileReader();
                        newReader.onload = (event) => {
                            mainImageDiv.innerHTML = '';
                            const newImg = document.createElement('img');
                            newImg.src = event.target.result;
                            newImg.style.width = '100%';
                            newImg.style.height = '100%';
                            newImg.style.objectFit = 'cover';
                            mainImageDiv.appendChild(newImg);
                        };
                        newReader.readAsDataURL(uploadedFiles[0]);
                    }
                });
        
                wrapper.appendChild(filename);
                wrapper.appendChild(removeBtn);
                thumbnailBox.appendChild(wrapper);
        
                if (uploadedFiles.length === 1) {
                    const mainImageDiv = document.querySelector('.main-image');
                    mainImageDiv.innerHTML = '';
                    const mainImg = document.createElement('img');
                    mainImg.src = e.target.result;
                    mainImg.style.width = '100%';
                    mainImg.style.height = '100%';
                    mainImg.style.objectFit = 'cover';
                    mainImageDiv.appendChild(mainImg);
                }
        
                updateSubThumbnails();
            };
            reader.readAsDataURL(file);
        }
        
        function updateSubThumbnails() {
            const subThumbs = document.querySelectorAll('.sub-thumb');
            
            while (uploadedFiles.length > 4) {
                uploadedFiles.splice(4, 1);
            }
        
            subThumbs.forEach((thumb, index) => {
                thumb.innerHTML = '';
                const file = uploadedFiles[index + 1];
                if (file) {
                    const reader = new FileReader();
                    reader.onload = (e) => {
                        const img = document.createElement('img');
                        img.src = e.target.result;
        
                        const removeBtn = document.createElement('button');
                        removeBtn.textContent = '✖';
                        removeBtn.addEventListener('click', () => {
                            uploadedFiles = uploadedFiles.filter(f => f !== file);
                            updateMainImage();
                            updateSubThumbnails();
                            updateFilenameList();
                        });
        
                        thumb.appendChild(img);
                        thumb.appendChild(removeBtn);
                    };
                    reader.readAsDataURL(file);
                }
            });
        }
        
        function updateMainImage() {
            const mainImageDiv = document.querySelector('.main-image');
            mainImageDiv.innerHTML = '';
        
            if (uploadedFiles.length === 0) {
                mainImageDiv.innerHTML = '<span>이미지 영역</span>';
                return;
            }
        
            const reader = new FileReader();
            reader.onload = (e) => {
                const img = document.createElement('img');
                img.src = e.target.result;
                img.style.width = '100%';
                img.style.height = '100%';
                img.style.objectFit = 'cover';
                mainImageDiv.appendChild(img);
            };
            reader.readAsDataURL(uploadedFiles[0]);
        }
        
        function updateFilenameList() {
            thumbnailBox.innerHTML = '';
            uploadedFiles.forEach(file => {
                const wrapper = document.createElement('span');
                wrapper.style.display = 'inline-flex';
                wrapper.style.alignItems = 'center';
                wrapper.style.marginRight = '10px';
        
                const filename = document.createElement('span');
                filename.textContent = file.name;
        
                const removeBtn = document.createElement('button');
                removeBtn.textContent = '✖';
                removeBtn.style.marginLeft = '4px';
                removeBtn.style.background = 'transparent';
                removeBtn.style.border = 'none';
                removeBtn.style.color = 'red';
                removeBtn.style.cursor = 'pointer';
                removeBtn.style.fontSize = '13px';
                removeBtn.style.padding = '0';
        
                removeBtn.addEventListener('click', () => {
                    uploadedFiles = uploadedFiles.filter(f => f !== file);
                    updateMainImage();
                    updateSubThumbnails();
                    updateFilenameList();
                });
        
                wrapper.appendChild(filename);
                wrapper.appendChild(removeBtn);
                thumbnailBox.appendChild(wrapper);
            });
        }
        function displayBigImage(file) {
        const reader = new FileReader();
        reader.onload = (e) => {
            const slot = document.createElement('div');
            slot.className = 'big-img-slot';

            const img = document.createElement('img');
            img.src = e.target.result;

            const removeBtn = document.createElement('button');
            removeBtn.textContent = '✖';
            removeBtn.onclick = () => {
                bigImages = bigImages.filter(f => f !== file);
                slot.remove();
            };

            slot.appendChild(img);
            slot.appendChild(removeBtn);
            bigPreviewBox.appendChild(slot);
        };
        reader.readAsDataURL(file);
    }
    </script>



    </body>

    </html>