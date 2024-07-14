const express = require('express');
const fileUpload = require('express-fileupload');
const sharp = require('sharp');

const app = express();

const port = 3000;
const apiUrl = 'http://135.148.168.28:'+port+'/'

app.use(express.urlencoded({ extended: false, limit: '10mb' }));
app.use(
    fileUpload({
        limits: {
            fileSize: 10 * 1000000, // 10MB
        },
        abortOnLimit: true,
    })
);

app.use(express.static('public'));

// app.get('/', (req, res) => {
//     res.send('online');
// });

let proccessImage = (image, folder, width, height) => {
    sharp(image.data).resize(width, height, {
        fit: sharp.fit.inside,
        withoutEnlargement: false
    }).jpeg({ mozjpeg: true }).toFile(__dirname + '/public/uploads/' + folder + '/' + image.md5 + '.jpg');

    return {
        status: 'done',
        url: apiUrl + 'uploads/' + folder + '/' + image.md5 + '.jpg'
    }
}

app.post('/upload-thumb', (req, res) => {
    // console.log('NEW UPLOAD THUMB: ', JSON.stringify(req.params))
    // console.log('NEW UPLOAD FILES: ', JSON.stringify(req.files))
    const { img } = req.files;
    if (!img) return res.sendStatus(400);

    res.send(proccessImage(img, 'thumb', 120, 120));
});

app.post('/upload-bg', (req, res) => {
    const { image } = req.files;
    if (!image) return res.sendStatus(400);

    res.send(proccessImage(image, 'bg', 1080, 160));
});

app.listen(port, () => {
    console.log(`API Online: ${apiUrl}`);
});