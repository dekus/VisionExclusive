local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

RegisterNetEvent("personagem:startIntro")
RegisterNetEvent("personagem:normalSpawn")
RegisterNetEvent("personagem:characterCreate")

-- VARIABLES -- 
local cam = nil
local freezedOnTop = true
local doStatus = -1
local continuousFadeOutNetwork = false

function f(n)
	n = n + 0.00000
	return n
end
function setCamHeight(height)
	local pos = GetEntityCoords(PlayerPedId())
	SetCamCoord(cam,vector3(pos.x,pos.y,f(height)))
	StartScreenEffect("DeathFailNeutralIn", 0, true)
end
local function StartFade()
	DoScreenFadeOut(300)
	while IsScreenFadingOut() do
		Wait(0)
	end
end
local function EndFade()
	ShutdownLoadingScreen()
  DoScreenFadeIn(500)
  while IsScreenFadingIn() do
    Wait(0)
  end
end

CreateThread(function()
	SetNuiFocus(false,false)
	SetEntityInvincible(PlayerPedId(),false)
	SetEntityVisible(PlayerPedId(),false)
	FreezeEntityPosition(PlayerPedId(),true)
	SetPedDiesInWater(PlayerPedId(), 0)
	TriggerCamController(doStatus)
	while freezedOnTop do
		if doStatus == 1 then
			SetEntityInvincible(PlayerPedId(),false)
			SetEntityVisible(PlayerPedId(),true)
			FreezeEntityPosition(PlayerPedId(),true)
			SetPedDiesInWater(PlayerPedId(), 1)
		elseif doStatus == 2 then
			TriggerCamController(doStatus)
			SetEntityInvincible(PlayerPedId(),false)
			SetEntityVisible(PlayerPedId(),true)
			FreezeEntityPosition(PlayerPedId(),false)
			SetPedDiesInWater(PlayerPedId(), 1)
			TriggerCamController(-2)
			freezedOnTop = false
		else
			SetEntityInvincible(PlayerPedId(),false)
			SetEntityVisible(PlayerPedId(),false)
			FreezeEntityPosition(PlayerPedId(),true)
		end
		Wait(0)
	end
end)

function TriggerCamController(statusSent)
	if not DoesCamExist(cam) then
		cam = CreateCam("DEFAULT_SCRIPTED_CAMERA",false)
	end
	if statusSent == -1 then
		local pos = GetEntityCoords(PlayerPedId())
		SetCamCoord(cam,vector3(pos.x,pos.y,f(1500)))
		SetCamRot(cam,-f(90),f(0),f(0),2)
		SetCamActive(cam, true)
		StopCamPointing(cam)
		RenderScriptCams(true,true,0,0,0,0)
		StartScreenEffect("DeathFailNeutralIn",0,true)
	elseif statusSent == 2 then
		Wait(1000)
		setCamHeight(1000)
		Wait(1000)
		setCamHeight(750)
		Wait(1000)
		setCamHeight(400)
		Wait(1000)
		setCamHeight(100)
		Wait(2000)
	elseif statusSent == -2 then
		SetCamActive(cam,false)
		StopCamPointing(cam)
		RenderScriptCams(0,0,0,0,0,0)
		SetFocusEntity(PlayerPedId())
		StopScreenEffect("DeathFailNeutralIn")

	elseif statusSent == 1 then
		SetCamCoord(cam,vector3(402.6,-997.25,-98.32))
		SetCamRot(cam, f(0), f(0), f(358), 15)
		SetCamActive(cam, true)
		RenderScriptCams(true,true,20000000000000000000000000,0,0,0)
	end
end

AddEventHandler("personagem:startIntro", function()
	doStatus = -1
	SetTimeout(1000, function()
		TriggerServerEvent("personagem:finishedIntro")
	end)
end)



AddEventHandler("personagem:characterCreate", function()
	doStatus = 1
	SetTimeout(3000, function()
		TriggerCreateCharacter()
	end)
end)

AddEventHandler("personagem:normalSpawn",function(firstspawn)
	if firstspawn then
		TriggerCamController(-1)
		EndFade()
		doStatus = 2
		TriggerCamController(doStatus)
	else
		TriggerCamController(-1)
		TriggerEvent("vrp:ToogleLoginMenu")
	end
end)

RegisterNetEvent('ToogleBackCharacter')
AddEventHandler('ToogleBackCharacter',function()
  doStatus = 2
end)




--=============================================== Character Create ===============================================--
local isInCharacterMode = false

local currentCharacterMode = { fathersID = 0, mothersID = 0, skinColor = 0, shapeMix = 0.0,
eyesColor = 0, eyebrowsHeight = 0, eyebrowsWidth = 0, noseWidth = 0,
noseHeight = 0, noseLength = 0, noseBridge = 0, noseTip = 0, noseShift = 0,
cheekboneHeight = 0, cheekboneWidth = 0, cheeksWidth = 0, lips = 0, jawWidth = 0,
jawHeight = 0, chinLength = 0, chinPosition = 0,
chinWidth = 0, chinShape = 0, neckWidth = 0,
hairModel = 4, firstHairColor = 0, secondHairColor = 0, eyebrowsModel = 0, eyebrowsColor = 0,
beardModel = -1, beardColor = 0, chestModel = -1, chestColor = 0, blushModel = -1, blushColor = 0, lipstickModel = -1, lipstickColor = 0,
blemishesModel = -1, ageingModel = -1, complexionModel = -1, sundamageModel = -1, frecklesModel = -1, makeupModel = -1 }
local characterNome = ""
local characterSobrenome = ""
local characterAge = 0

function TriggerCreateCharacter()
		TriggerCamController(-1) -- reset to top
		isInCharacterMode = true
		StartFade()
		continuousFadeOutNetwork = true
		TriggerCamController(-2) -- remove cam
		changeGender("mp_m_freemode_01")
		refreshDefaultCharacter()
		TaskUpdateSkinOptions()
		TaskUpdateFaceOptions()
		TaskUpdateHeadOptions()

		SetEntityCoordsNoOffset(PlayerPedId(), 402.55, -996.37, -99.01, true, true, true) 
		SetEntityHeading(PlayerPedId(), f(180))
		TriggerCamController(doStatus)
		Wait(5000)

		EndFade()
		SetNuiFocus(isInCharacterMode, isInCharacterMode) -- focus, cursor
		SendNUIMessage({CharacterMode = isInCharacterMode, CharacterMode2 = not isInCharacterMode, CharacterMode3 = not isInCharacterMode})
end

function refreshDefaultCharacter()
	SetPedDefaultComponentVariation(PlayerPedId())
	ClearAllPedProps(PlayerPedId())
	if GetEntityModel(PlayerPedId()) == GetHashKey("mp_m_freemode_01") then
		SetPedComponentVariation(PlayerPedId(),1,-1,0,2)
		SetPedComponentVariation(PlayerPedId(),5,-1,0,2)
		SetPedComponentVariation(PlayerPedId(),7,-1,0,2)
		SetPedComponentVariation(PlayerPedId(),3,15,0,2)
		SetPedComponentVariation(PlayerPedId(),4,61,0,2)
		SetPedComponentVariation(PlayerPedId(),8,15,0,2)
		SetPedComponentVariation(PlayerPedId(),6,16,0,2)
		SetPedComponentVariation(PlayerPedId(),11,104,0,2)
		SetPedComponentVariation(PlayerPedId(),9,-1,0,2)
		SetPedComponentVariation(PlayerPedId(),10,-1,0,2)
		SetPedPropIndex(PlayerPedId(),2,-1,0,2)
		SetPedPropIndex(PlayerPedId(),6,-1,0,2)
		SetPedPropIndex(PlayerPedId(),7,-1,0,2)
	else
		SetPedComponentVariation(PlayerPedId(),1,-1,0,2)
		SetPedComponentVariation(PlayerPedId(),5,-1,0,2)
		SetPedComponentVariation(PlayerPedId(),7,-1,0,2)
		SetPedComponentVariation(PlayerPedId(),3,15,0,2)
		SetPedComponentVariation(PlayerPedId(),4,15,0,2)
		SetPedComponentVariation(PlayerPedId(),8,7,0,2)
		SetPedComponentVariation(PlayerPedId(),6,5,0,2)
		SetPedComponentVariation(PlayerPedId(),11,5,0,2)
		SetPedComponentVariation(PlayerPedId(),9,-1,0,2)
		SetPedComponentVariation(PlayerPedId(),10,-1,0,2)
		SetPedPropIndex(PlayerPedId(),2,-1,0,2)
		SetPedPropIndex(PlayerPedId(),6,-1,0,2)
		SetPedPropIndex(PlayerPedId(),7,-1,0,2)
	end
end

function changeGender(model)
	local mhash = GetHashKey(model)
	while not HasModelLoaded(mhash) do
		RequestModel(mhash)
		Wait(10)
	end

	if HasModelLoaded(mhash) then
		SetPlayerModel(PlayerId(), mhash)
		SetPedMaxHealth(PlayerPedId(),400)
		vRP.setHealth(400)
		SetModelAsNoLongerNeeded(mhash)
	end
end

CreateThread(function()
	while true do 
		Wait(1)
		if continuousFadeOutNetwork then 
	        for id = 0, 256 do
				if id ~= PlayerId() and NetworkIsPlayerActive(id) then
					NetworkFadeOutEntity(GetPlayerPed(id), false)
				end
			end
		else
			Wait(1000)
		end
	end
end)

-- Character NUI Callbacks
RegisterNUICallback('cDone', function(data, cb)
	SetNuiFocus(isInCharacterMode, isInCharacterMode) -- focus, cursor
	SendNUIMessage({CharacterMode = not isInCharacterMode, CharacterMode2 = isInCharacterMode, CharacterMode3 = not isInCharacterMode})
	--cb('ok')
end)

RegisterNUICallback('BackPart1', function(data, cb)
	SetNuiFocus(isInCharacterMode, isInCharacterMode) -- focus, cursor
	SendNUIMessage({CharacterMode = isInCharacterMode, CharacterMode2 = not isInCharacterMode, CharacterMode3 = not isInCharacterMode})
	--cb('ok')
end)

RegisterNUICallback('cDonePart2', function(data, cb)
	SetNuiFocus(isInCharacterMode, isInCharacterMode) -- focus, cursor
	SendNUIMessage({CharacterMode = not isInCharacterMode, CharacterMode2 = not isInCharacterMode, CharacterMode3 = isInCharacterMode})
	--cb('ok')
end)

RegisterNUICallback('BackPart2', function(data, cb)
	SetNuiFocus(isInCharacterMode, isInCharacterMode) -- focus, cursor
	SendNUIMessage({CharacterMode = not isInCharacterMode, CharacterMode2 = isInCharacterMode, CharacterMode3 = not isInCharacterMode})
	--cb('ok')
end)

RegisterNUICallback('cDoneSave', function(data, cb)
	StartFade()

	isInCharacterMode = false
	SetNuiFocus(isInCharacterMode, isInCharacterMode) -- focus, cursor
	SendNUIMessage({CharacterMode = isInCharacterMode, CharacterMode2 = isInCharacterMode, CharacterMode3 = isInCharacterMode})
	
	-- Sets Initial Clothes
	SetPedComponentVariation(PlayerPedId(), 3, 0, 0, 2)

	if GetEntityModel(PlayerPedId()) == GetHashKey("mp_m_freemode_01") then
		SetPedComponentVariation(PlayerPedId(),1,-1,0,2) -- BARBA
		SetPedComponentVariation(PlayerPedId(),2,-1,0,2) -- CABELO
		SetPedComponentVariation(PlayerPedId(),3,0,0,2) -- MAOS
		SetPedComponentVariation(PlayerPedId(),4,26,0,2) -- CALCA
		SetPedComponentVariation(PlayerPedId(),5,-1,0,2) -- BRACELETES
		SetPedComponentVariation(PlayerPedId(),6,59,4,2) -- SAPATOS
		SetPedComponentVariation(PlayerPedId(),7,-1,0,2)
		SetPedComponentVariation(PlayerPedId(),8,15,0,2) -- BLUSA
		SetPedComponentVariation(PlayerPedId(),9,-1,0,2) -- MOCHILA
		SetPedComponentVariation(PlayerPedId(),10,-1,0,2) -- MASCARA
		SetPedComponentVariation(PlayerPedId(),11,0,4,2) -- JAQUETA
		SetPedPropIndex(PlayerPedId(),0,-1,0,2) -- CHAPEU
		SetPedPropIndex(PlayerPedId(),1,-1,0,2) -- OCULOS
		SetPedPropIndex(PlayerPedId(),2,-1,0,2) -- BRINCOS, ETC
		SetPedPropIndex(PlayerPedId(),6,-1,0,2)
		SetPedPropIndex(PlayerPedId(),7,-1,0,2)
	else
		SetPedComponentVariation(PlayerPedId(),1,-1,0,2)
		SetPedComponentVariation(PlayerPedId(),2,10,0,2)
		SetPedComponentVariation(PlayerPedId(),3,3,0,2)
		SetPedComponentVariation(PlayerPedId(),4,43,0,2)
		SetPedComponentVariation(PlayerPedId(),5,-1,0,2)
		SetPedComponentVariation(PlayerPedId(),6,27,0,2)
		SetPedComponentVariation(PlayerPedId(),7,-1,0,2)
		SetPedComponentVariation(PlayerPedId(),8,-1,0,2)
		SetPedComponentVariation(PlayerPedId(),9,-1,0,2)
		SetPedComponentVariation(PlayerPedId(),10,-1,0,2)
		SetPedComponentVariation(PlayerPedId(),11,3,0,2)
		SetPedPropIndex(PlayerPedId(),0,-1,0,2)
		SetPedPropIndex(PlayerPedId(),1,9,0,2)
		SetPedPropIndex(PlayerPedId(),2,-1,0,2)
		SetPedPropIndex(PlayerPedId(),6,-1,0,2)
		SetPedPropIndex(PlayerPedId(),7,-1,0,2)
	end

	SetEntityCoordsNoOffset(PlayerPedId(),239.48,-1380.9,33.75,true,true,true)
	SetEntityHeading(PlayerPedId(),f(1.77))

	continuousFadeOutNetwork = false

	for id = 0, 256 do
		if id ~= PlayerId() and NetworkIsPlayerActive(id) then
			NetworkFadeInEntity(GetPlayerPed(id), true)
		end
	end

	TriggerServerEvent("personagem:finishedCharacter", characterNome, characterSobrenome, characterAge, currentCharacterMode)
end)

RegisterNUICallback('cChangeHeading', function(data, cb)
	SetEntityHeading(PlayerPedId(), f(data.camRotation))
    cb('ok')
end)

RegisterNUICallback('ChangeGender', function(data, cb)
    currentCharacterMode.gender = data.gender
    if data.gender == 1 then
    	changeGender("mp_f_freemode_01")
    else
    	changeGender("mp_m_freemode_01")
    end
	refreshDefaultCharacter()
	TaskUpdateSkinOptions()
	TaskUpdateFaceOptions()
	TaskUpdateHeadOptions()
    cb('ok')
end)

RegisterNUICallback('UpdateRgOptions',function(data,cb)
		characterNome = data.characterNome
		characterSobrenome = data.characterSobrenome
		characterAge = data.characterAge
		TaskUpdateRgOptions()
	cb('ok')
end)

function TaskUpdateRgOptions()
	local data = currentCharacterMode
end

RegisterNUICallback('UpdateSkinOptions', function(data, cb)
	currentCharacterMode.fathersID = data.fathersID
	currentCharacterMode.mothersID = data.mothersID
	currentCharacterMode.skinColor = data.skinColor
	currentCharacterMode.shapeMix = data.shapeMix
    TaskUpdateSkinOptions()
    cb('ok')
end)

function TaskUpdateSkinOptions()
	local data = currentCharacterMode
	SetPedHeadBlendData(PlayerPedId(), data.fathersID, data.mothersID, 0, data.skinColor, 0, 0, f(data.shapeMix), 0, 0, false)
end

RegisterNUICallback('UpdateFaceOptions', function(data, cb)
	currentCharacterMode.eyesColor = data.eyesColor
	currentCharacterMode.eyebrowsHeight = data.eyebrowsHeight
	currentCharacterMode.eyebrowsWidth = data.eyebrowsWidth
	currentCharacterMode.noseWidth = data.noseWidth
	currentCharacterMode.noseHeight = data.noseHeight
	currentCharacterMode.noseLength = data.noseLength
	currentCharacterMode.noseBridge = data.noseBridge
	currentCharacterMode.noseTip = data.noseTip
	currentCharacterMode.noseShift = data.noseShift
	currentCharacterMode.cheekboneHeight = data.cheekboneHeight
	currentCharacterMode.cheekboneWidth = data.cheekboneWidth
	currentCharacterMode.cheeksWidth = data.cheeksWidth
	currentCharacterMode.lips = data.lips
	currentCharacterMode.jawWidth = data.jawWidth
	currentCharacterMode.jawHeight = data.jawHeight
	currentCharacterMode.chinLength = data.chinLength
	currentCharacterMode.chinPosition = data.chinPosition
	currentCharacterMode.chinWidth = data.chinWidth
	currentCharacterMode.chinShape = data.chinShape
	currentCharacterMode.neckWidth = data.neckWidth

	TaskUpdateFaceOptions()

	cb('ok')
end)

function TaskUpdateFaceOptions()
	local ped = PlayerPedId()
	local data = currentCharacterMode

	-- Olhos
	SetPedEyeColor(ped, data.eyesColor)

	-- Sobrancelha
	SetPedFaceFeature(ped, 6, data.eyebrowsHeight)
	SetPedFaceFeature(ped, 7, data.eyebrowsWidth)
	-- Nariz
	SetPedFaceFeature(ped, 0, data.noseWidth)
	SetPedFaceFeature(ped, 1, data.noseHeight)
	SetPedFaceFeature(ped, 2, data.noseLength)
	SetPedFaceFeature(ped, 3, data.noseBridge)
	SetPedFaceFeature(ped, 4, data.noseTip)
	SetPedFaceFeature(ped, 5, data.noseShift)

	-- Bochechas
	SetPedFaceFeature(ped, 8, data.cheekboneHeight)
	SetPedFaceFeature(ped, 9, data.cheekboneWidth)
	SetPedFaceFeature(ped, 10, data.cheeksWidth)

	-- Boca/Mandibula
	SetPedFaceFeature(ped, 12, data.lips)
	SetPedFaceFeature(ped, 13, data.jawWidth)
	SetPedFaceFeature(ped, 14, data.jawHeight)
	-- Queixo
	SetPedFaceFeature(ped, 15, data.chinLength)
	SetPedFaceFeature(ped, 16, data.chinPosition)
	SetPedFaceFeature(ped, 17, data.chinWidth)
	SetPedFaceFeature(ped, 18, data.chinShape)
	-- Pescoço
	SetPedFaceFeature(ped, 19, data.neckWidth)
end

RegisterNUICallback('UpdateHeadOptions', function(data, cb)
	currentCharacterMode.hairModel = data.hairModel
	currentCharacterMode.firstHairColor = data.firstHairColor
	currentCharacterMode.secondHairColor = data.secondHairColor
	currentCharacterMode.eyebrowsModel = data.eyebrowsModel
	currentCharacterMode.eyebrowsColor = data.eyebrowsColor
	currentCharacterMode.beardModel = data.beardModel
	currentCharacterMode.beardColor = data.beardColor
    currentCharacterMode.chestModel = data.chestModel
    currentCharacterMode.chestColor = data.chestColor
    currentCharacterMode.blushModel = data.blushModel
    currentCharacterMode.blushColor = data.blushColor
    currentCharacterMode.lipstickModel = data.lipstickModel
    currentCharacterMode.lipstickColor = data.lipstickColor
	currentCharacterMode.blemishesModel = data.blemishesModel
	currentCharacterMode.ageingModel = data.ageingModel
	currentCharacterMode.complexionModel = data.complexionModel
	currentCharacterMode.sundamageModel = data.sundamageModel
	currentCharacterMode.frecklesModel = data.frecklesModel
	currentCharacterMode.makeupModel = data.makeupModel

	TaskUpdateHeadOptions()
	cb('ok')
end)

function TaskUpdateHeadOptions()
	local ped = PlayerPedId()
	local data = currentCharacterMode
	-- Cabelo
	SetPedComponentVariation(ped, 2, data.hairModel, 0, 0)
	SetPedHairColor(ped, data.firstHairColor, data.secondHairColor)

	-- Sobracelha 
	SetPedHeadOverlay(ped, 2, data.eyebrowsModel, 0.99)
	SetPedHeadOverlayColor(ped, 2, 1, data.eyebrowsColor, data.eyebrowsColor)

	-- Barba
	SetPedHeadOverlay(ped, 1, data.beardModel, 0.99)
	SetPedHeadOverlayColor(ped, 1, 1, data.beardColor, data.beardColor)

    -- Pelo Corporal
    SetPedHeadOverlay(ped, 10, data.chestModel, 0.99)
    SetPedHeadOverlayColor(ped, 10, 1, data.chestColor, data.chestColor)

    -- Blush
    SetPedHeadOverlay(ped, 5, data.blushModel, 0.99)
    SetPedHeadOverlayColor(ped, 5, 2, data.blushColor, data.blushColor)

    -- Battom
    SetPedHeadOverlay(ped, 8, data.lipstickModel, 0.99)
    SetPedHeadOverlayColor(ped, 8, 2, data.lipstickColor, data.lipstickColor)

	-- Manchas
	SetPedHeadOverlay(ped, 0, data.blemishesModel, 0.99)
	SetPedHeadOverlayColor(ped, 0, 0, 0, 0)

	-- Envelhecimento
	SetPedHeadOverlay(ped, 3, data.ageingModel, 0.99)
	SetPedHeadOverlayColor(ped, 3, 0, 0, 0)

	-- Aspecto
	SetPedHeadOverlay(ped, 6, data.complexionModel, 0.99)
	SetPedHeadOverlayColor(ped, 6, 0, 0, 0)

	-- Pele
	SetPedHeadOverlay(ped, 7, data.sundamageModel, 0.99)
	SetPedHeadOverlayColor(ped, 7, 0, 0, 0)

	-- Sardas
	SetPedHeadOverlay(ped, 9, data.frecklesModel, 0.99)
	SetPedHeadOverlayColor(ped, 9, 0, 0, 0)

	-- Maquiagem
	SetPedHeadOverlay(ped, 4, data.makeupModel, 0.99)
	SetPedHeadOverlayColor(ped, 4, 0, 0, 0)
end
--=========================================== End Character Create ==========================================--