BattleCommand_Growth:
  ld bc, wPlayerStatLevels
	ldh a, [hBattleTurn]
	and a
	jr z, .go
	ld bc, wEnemyStatLevels

.go
; If no stats can be increased, don't.
	ld a, [bc]
	cp MAX_STAT_LEVEL
	jr c, .raise

; Special Attack
	inc bc
  inc bc
  inc bc
	ld a, [bc]
	cp MAX_STAT_LEVEL
	jr nc, .cantraise

.raise
  ld a, $1
	ld [wBattleAnimParam], a
	call AnimateCurrentMove

; Check for Sunny Day
	ld a, [wBattleWeather]
	cp $02
	jr z, .SunnyDay

; Normal stat increases if no Sunny Day
  call ResetMiss
	call BattleCommand_AttackUp
	call BattleCommand_StatUpMessage

	call ResetMiss
	call BattleCommand_SpecialAttackUp
	jp BattleCommand_StatUpMessage

.SunnyDay
; Doubled stat increases under Sunny Day
  call ResetMiss
	call BattleCommand_AttackUp2
	call BattleCommand_StatUpMessage

	call ResetMiss
	call BattleCommand_SpecialAttackUp2
	jp BattleCommand_StatUpMessage

.cantraise
	ld b, ABILITY + 1
	call GetStatName
	call AnimateFailedMove
	ld hl, WontRiseAnymoreText
	jp StdBattleTextbox
