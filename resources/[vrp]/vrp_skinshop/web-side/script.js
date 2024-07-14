cReative = {}
var selectedTab = '.characterTab',
  lastCategory = 'character',
  selectedCam = null,
  clothingCategorys = []
const skinData = {
  pants: {
    defaultItem: 0,
    defaultTexture: 0,
  },
  arms: {
    defaultItem: 0,
    defaultTexture: 0,
  },
  tshirt: {
    defaultItem: 1,
    defaultTexture: 0,
  },
  torso: {
    defaultItem: 0,
    defaultTexture: 0,
  },
  vest: {
    defaultItem: 0,
    defaultTexture: 0,
  },
  shoes: {
    defaultItem: 1,
    defaultTexture: 0,
  },
  mask: {
    defaultItem: 0,
    defaultTexture: 0,
  },
  hat: {
    defaultItem: -1,
    defaultTexture: 0,
  },
  glass: {
    defaultItem: 0,
    defaultTexture: 0,
  },
  ear: {
    defaultItem: -1,
    defaultTexture: 0,
  },
  watch: {
    defaultItem: -1,
    defaultTexture: 0,
  },
  bracelet: {
    defaultItem: -1,
    defaultTexture: 0,
  },
  accessory: {
    defaultItem: 0,
    defaultTexture: 0,
  },
  bag: {
    defaultItem: 0,
    defaultTexture: 0,
  },
  decals: {
    defaultItem: 0,
    defaultTexture: 0,
  },
}
$(document).on('click', '.clothing-menu-header-btn', function (_0x203097) {
  var _0x6d8c61 = $(this).data('category')
  $(selectedTab).removeClass('selected')
  $(this).addClass('selected')
  $('.clothing-menu-' + lastCategory + '-container').css({ display: 'none' })
  lastCategory = _0x6d8c61
  selectedTab = this
  $('.clothing-menu-' + _0x6d8c61 + '-container').css({ display: 'block' })
})
cReative.ResetItemTexture = function (_0x3f0ba5, _0x525ebb) {
  var _0x27430e = $(_0x3f0ba5).parent().parent().find('[data-type="texture"]'),
    _0x16a557 = skinData[_0x525ebb].defaultTexture
  $(_0x27430e).val(_0x16a557)
  $.post(
    'http://vrp_skinshop/updateSkin',
    JSON.stringify({
      clothingType: _0x525ebb,
      articleNumber: _0x16a557,
      type: 'texture',
    })
  )
}
$(document).on(
  'click',
  '.clothing-menu-option-item-right',
  function (_0x39b491) {
    _0x39b491.preventDefault()
    var _0x20a2c2 = $(this).parent().parent().parent().parent().data('type'),
      _0x3cc14c = $(this).data('type'),
      _0x109b1d = $(this).parent().find('input'),
      _0xc03628 = $(_0x109b1d).val(),
      _0x193bce = parseFloat(_0xc03628) + 1
    if (_0x20a2c2 == 'hair') {
      $(_0x109b1d).val(_0x193bce)
      $.post(
        'http://vrp_skinshop/updateSkin',
        JSON.stringify({
          clothingType: _0x20a2c2,
          articleNumber: _0x193bce,
          type: _0x3cc14c,
        })
      )
      _0x3cc14c == 'item' && cReative.ResetItemTexture(this, _0x20a2c2)
    } else {
      if (_0x3cc14c == 'item') {
        var _0x4f3e3a = $(this)
          .parent()
          .parent()
          .find('[data-headertype="item-header"]')
          .data('maxItem')
        _0x20a2c2 == 'accessory' && _0x193bce == 13
          ? ($(_0x109b1d).val(14),
            $.post(
              'http://vrp_skinshop/updateSkin',
              JSON.stringify({
                clothingType: _0x20a2c2,
                articleNumber: 14,
                type: _0x3cc14c,
              })
            ))
          : _0x193bce <= parseInt(_0x4f3e3a) &&
            ($(_0x109b1d).val(_0x193bce),
            $.post(
              'http://vrp_skinshop/updateSkin',
              JSON.stringify({
                clothingType: _0x20a2c2,
                articleNumber: _0x193bce,
                type: _0x3cc14c,
              })
            ))
        cReative.ResetItemTexture(this, _0x20a2c2)
      } else {
        var _0x4f3e3a = $(this)
          .parent()
          .parent()
          .find('[data-headertype="texture-header"]')
          .data('maxTexture')
        _0x193bce <= parseInt(_0x4f3e3a) &&
          ($(_0x109b1d).val(_0x193bce),
          $.post(
            'http://vrp_skinshop/updateSkin',
            JSON.stringify({
              clothingType: _0x20a2c2,
              articleNumber: _0x193bce,
              type: _0x3cc14c,
            })
          ))
      }
    }
  }
)
$(document).on(
  'click',
  '.clothing-menu-option-item-left',
  function (_0x2fe272) {
    _0x2fe272.preventDefault()
    var _0x1cbcf5 = $(this).parent().parent().parent().parent().data('type'),
      _0x4f8b3e = $(this).data('type'),
      _0x3794b4 = $(this).parent().find('input'),
      _0x13a634 = $(_0x3794b4).val(),
      _0x54d1bd = parseFloat(_0x13a634) - 1
    _0x4f8b3e == 'item'
      ? (_0x54d1bd >= skinData[_0x1cbcf5].defaultItem &&
          (_0x1cbcf5 == 'accessory' && _0x54d1bd == 13
            ? ($(_0x3794b4).val(12),
              $.post(
                'http://vrp_skinshop/updateSkin',
                JSON.stringify({
                  clothingType: _0x1cbcf5,
                  articleNumber: 12,
                  type: _0x4f8b3e,
                })
              ))
            : ($(_0x3794b4).val(_0x54d1bd),
              $.post(
                'http://vrp_skinshop/updateSkin',
                JSON.stringify({
                  clothingType: _0x1cbcf5,
                  articleNumber: _0x54d1bd,
                  type: _0x4f8b3e,
                })
              ))),
        cReative.ResetItemTexture(this, _0x1cbcf5))
      : _0x54d1bd >= skinData[_0x1cbcf5].defaultTexture &&
        (_0x1cbcf5 == 'accessory' && _0x54d1bd == 13
          ? ($(_0x3794b4).val(12),
            $.post(
              'http://vrp_skinshop/updateSkin',
              JSON.stringify({
                clothingType: _0x1cbcf5,
                articleNumber: 12,
                type: _0x4f8b3e,
              })
            ))
          : ($(_0x3794b4).val(_0x54d1bd),
            $.post(
              'http://vrp_skinshop/updateSkin',
              JSON.stringify({
                clothingType: _0x1cbcf5,
                articleNumber: _0x54d1bd,
                type: _0x4f8b3e,
              })
            )))
  }
)
var changingCat = null
function ChangeUp() {
  var _0x1a22ae = $(changingCat)
      .parent()
      .parent()
      .parent()
      .parent()
      .data('type'),
    _0x409e84 = $(changingCat).data('type'),
    _0x535d9a = parseFloat($(changingCat).val())
  _0x1a22ae == 'accessory' && _0x535d9a + 1 == 13 && $(changingCat).val(13)
}
function ChangeDown() {
  var _0x189b6f = $(changingCat)
      .parent()
      .parent()
      .parent()
      .parent()
      .data('type'),
    _0x43ee6b = $(changingCat).data('type'),
    _0x504695 = parseFloat($(changingCat).val())
  _0x189b6f == 'accessory' && _0x504695 - 1 == 13 && $(changingCat).val(13)
}
$(document).on('change', '.item-number', function () {
  var _0x4b1e79 = $(this).parent().parent().parent().parent().data('type'),
    _0x50da2c = $(this).data('type'),
    _0x2bbdbe = $(this).val()
  changingCat = this
  _0x4b1e79 == 'accessory' && _0x2bbdbe == 13
    ? $(this).val(12)
    : $.post(
        'http://vrp_skinshop/updateSkinOnInput',
        JSON.stringify({
          clothingType: _0x4b1e79,
          articleNumber: parseFloat(_0x2bbdbe),
          type: _0x50da2c,
        })
      )
})
$(document).on(
  'click',
  '.clothing-menu-header-camera-btn',
  function (_0x436ec5) {
    _0x436ec5.preventDefault()
    var _0x2b5a18 = parseFloat($(this).data('value'))
    selectedCam == null
      ? ($(this).addClass('selected-cam'),
        $.post(
          'http://vrp_skinshop/setupCam',
          JSON.stringify({ value: _0x2b5a18 })
        ),
        (selectedCam = this))
      : selectedCam == this
      ? ($(selectedCam).removeClass('selected-cam'),
        $.post('http://vrp_skinshop/setupCam', JSON.stringify({ value: 0 })),
        (selectedCam = null))
      : ($(selectedCam).removeClass('selected-cam'),
        $(this).addClass('selected-cam'),
        $.post(
          'http://vrp_skinshop/setupCam',
          JSON.stringify({ value: _0x2b5a18 })
        ),
        (selectedCam = this))
  }
)
$(document).on('keydown', function () {
  switch (event.keyCode) {
    case 68:
      $.post('http://vrp_skinshop/rotateRight')
      break
    case 65:
      $.post('http://vrp_skinshop/rotateLeft')
      break
    case 38:
      ChangeUp()
      break
    case 40:
      ChangeDown()
      break
  }
})
$(document).ready(function () {
  window.addEventListener('message', function (_0x1795ea) {
    switch (_0x1795ea.data.action) {
      case 'open':
        cReative.Open(_0x1795ea.data)
        break
      case 'close':
        cReative.Close()
        break
      case 'updateMax':
        cReative.SetMaxValues(_0x1795ea.data.maxValues)
        break
    }
  })
})
$(document).on('click', '#save-menu', function (_0x19b2f3) {
  _0x19b2f3.preventDefault()
  cReative.Close()
  $.post('http://vrp_skinshop/saveClothing')
})
$(document).on('click', '#cancel-menu', function (_0x465db3) {
  _0x465db3.preventDefault()
  cReative.Close()
  $.post('http://vrp_skinshop/resetOutfit')
})
cReative.SetCurrentValues = function (_0x4ceeb5) {
  $.each(_0x4ceeb5, function (_0x1a7f70, _0x5b041a) {
    var _0x29a461 = $('.clothing-menu-container').find(
        '[data-type="' + _0x1a7f70 + '"]'
      ),
      _0x4adbdc = $(_0x29a461).find('input[data-type="item"]'),
      _0x583ec8 = $(_0x29a461).find('input[data-type="texture"]')
    $(_0x4adbdc).val(_0x5b041a.item)
    $(_0x583ec8).val(_0x5b041a.texture)
  })
}
cReative.Open = function (_0x510390) {
  clothingCategorys = _0x510390.currentClothing
  $('.clothing-menu-character-container').css('display', 'none')
  $('.clothing-menu-clothing-container').css('display', 'none')
  $('.clothing-menu-accessoires-container').css('display', 'none')
  $('body').css('display', 'block')
  cReative.SetMaxValues(_0x510390.maxValues)
  $('.clothing-menu-header').html('')
  cReative.SetCurrentValues(_0x510390.currentClothing)
  $.each(_0x510390.menus, function (_0x26e65f, _0x1f4a77) {
    _0x1f4a77.selected
      ? ($('.clothing-menu-header').append(
          '<div class="clothing-menu-header-btn ' +
            _0x1f4a77.menu +
            'Tab selected" data-category="' +
            _0x1f4a77.menu +
            '"><p>' +
            _0x1f4a77.label +
            '</p></div>'
        ),
        $('.clothing-menu-' + _0x1f4a77.menu + '-container').css({
          display: 'block',
        }),
        (selectedTab = '.' + _0x1f4a77.menu + 'Tab'),
        (lastCategory = _0x1f4a77.menu))
      : $('.clothing-menu-header').append(
          '<div class="clothing-menu-header-btn ' +
            _0x1f4a77.menu +
            'Tab" data-category="' +
            _0x1f4a77.menu +
            '"><p>' +
            _0x1f4a77.label +
            '</p></div>'
        )
  })
  var _0x33c599 = 100 / _0x510390.menus.length
  $('.clothing-menu-header-btn').css('width', _0x33c599 + '%')
}
cReative.Close = function () {
  $.post('http://vrp_skinshop/close')
  $('body').css('display', 'none')
  $(selectedCam).removeClass('selected-cam')
  $(selectedTab).removeClass('selected')
  selectedCam = null
  selectedTab = null
  lastCategory = null
}
cReative.SetMaxValues = function (_0x2404a0) {
  $.each(_0x2404a0, function (_0x4acc42, _0x149fe9) {
    if (_0x149fe9.type == 'character') {
      var _0x34ad73 = $('.clothing-menu-character-container').find(
          '[data-type="' + _0x4acc42 + '"]'
        ),
        _0x2b7dff = $(_0x34ad73).find('[data-headertype="item-header"]'),
        _0x7a0651 = $(_0x34ad73).find('[data-headertype="texture-header"]')
      _0x34ad73.data('type') != undefined &&
        ($(_0x2b7dff).data('maxItem', _0x2404a0[_0x34ad73.data('type')].item),
        $(_0x7a0651).data(
          'maxTexture',
          _0x2404a0[_0x34ad73.data('type')].texture
        ),
        $(_0x2b7dff).html(
          '<p><b>Modelli:</b> ' +
            _0x2404a0[_0x34ad73.data('type')].item +
            '</p>'
        ),
        $(_0x7a0651).html(
          '<p><b>Texturas:</b> ' +
            _0x2404a0[_0x34ad73.data('type')].texture +
            '</p>'
        ))
    } else {
      if (_0x149fe9.type == 'hair') {
        var _0x34ad73 = $('.clothing-menu-clothing-container').find(
            '[data-type="' + _0x4acc42 + '"]'
          ),
          _0x2b7dff = $(_0x34ad73).find('[data-headertype="item-header"]'),
          _0x7a0651 = $(_0x34ad73).find('[data-headertype="texture-header"]')
        _0x34ad73.data('type') != undefined &&
          ($(_0x2b7dff).data('maxItem', _0x2404a0[_0x34ad73.data('type')].item),
          $(_0x7a0651).data(
            'maxTexture',
            _0x2404a0[_0x34ad73.data('type')].texture
          ),
          $(_0x2b7dff).html(
            '<p><b>Modelli:</b> ' +
              _0x2404a0[_0x34ad73.data('type')].item +
              '</p>'
          ),
          $(_0x7a0651).html(
            '<p><b>Texturas:</b> ' +
              _0x2404a0[_0x34ad73.data('type')].texture +
              '</p>'
          ))
      } else {
        if (_0x149fe9.type == 'accessoires') {
          var _0x34ad73 = $('.clothing-menu-accessoires-container').find(
              '[data-type="' + _0x4acc42 + '"]'
            ),
            _0x2b7dff = $(_0x34ad73).find('[data-headertype="item-header"]'),
            _0x7a0651 = $(_0x34ad73).find('[data-headertype="texture-header"]')
          _0x34ad73.data('type') != undefined &&
            ($(_0x2b7dff).data(
              'maxItem',
              _0x2404a0[_0x34ad73.data('type')].item
            ),
            $(_0x7a0651).data(
              'maxTexture',
              _0x2404a0[_0x34ad73.data('type')].texture
            ),
            $(_0x2b7dff).html(
              '<p><b>Modelli:</b> ' +
                _0x2404a0[_0x34ad73.data('type')].item +
                '</p>'
            ),
            $(_0x7a0651).html(
              '<p><b>Texturas:</b> ' +
                _0x2404a0[_0x34ad73.data('type')].texture +
                '</p>'
            ))
        }
      }
    }
  })
}
$(document).on('click', '.change-camera-button', function (_0x3db1f3) {
  _0x3db1f3.preventDefault()
  var _0x1ae6bf = $(this).data('rotation')
  $.post('http://vrp_skinshop/rotateCam', JSON.stringify({ type: _0x1ae6bf }))
})
