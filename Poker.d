// ===============================
// === VARIABLES AND CONSTANTS ===
// ===============================
var int MIS_POKER;
const string TOPIC_POKER = "Koœciany poker";
const string POKER_INTERRUPTEDGAME = "Przerwano grê, wiêc pieni¹dze przepadaj¹.";
const string POKER_GAMBLER_NOTENOUGHMONEY = "Hazardzista nie ma na to pieniêdzy.";
const string POKER_BET_GOLD_5 = "(Stawiam 5 sztuk z³ota)";
const string POKER_BET_GOLD_35 = "(Stawiam 35 sztuk z³ota)";
const string POKER_BET_GOLD_65 = "(Stawiam 65 sztuk z³ota)";
const string POKER_BET_GOLD_95 = "(Stawiam 95 sztuk z³ota)";
const string POKER_BET_GOLD_15 = "(Stawiam 15 sztuk z³ota)";
const string POKER_BET_GOLD_45 = "(Stawiam 45 sztuk z³ota)";
const string POKER_BET_GOLD_75 = "(Stawiam 75 sztuk z³ota)";
const string POKER_BET_GOLD_105 = "(Stawiam 105 sztuk z³ota)";
const string POKER_BET_GOLD_25 = "(Stawiam 25 sztuk z³ota)";
const string POKER_BET_GOLD_55 = "(Stawiam 55 sztuk z³ota)";
const string POKER_BET_GOLD_85 = "(Stawiam 85 sztuk z³ota)";
const string POKER_BET_GOLD_115 = "(Stawiam 115 sztuk z³ota)";
const string POKER_MES_PLAYER_COMBINATION = "U ciebie %s";
const string POKER_MES_NPC_COMBINATION = "Przeciwnik ma %s";
const string POKER_MES_NOTHING = "nic";
const string POKER_SMALL_STREET = "Ma³y Street";
const string POKER_BIG_STREET = "Du¿y Street";
const string POKER_QUAD_OF = "Kareta z '%i'";
const string POKER_MES_FULL = "Full z '%i' i '%i'";
const string POKER_MES_THREE = "Trójka z '%i'";
const string POKER_MES_PAIR = "Para z '%i'";
const string POKER_MES_PAIRS = "Dwie pary z '%i' i '%i'";
const string POKER_MES_POKER = "Poker z '%i'";
const string POKER_MES_WIN = "Wygra³eœ!";
const string POKER_MES_LOSS = "Przegra³eœ!";
const string POKER_MES_TIE = "Remis!";

var int Poker_Log_GamblerHasNotMoney; // Czy zapisano graczowi komunikat, ¿e hazardzista mo¿e nie mieæ pieniêdzy.

// Player
var int playerturn; // Czy teraz jest tura gracza.
var int playerbone1;
var int playerbone2;
var int playerbone3;
var int playerbone4;
var int playerbone5;
var int playercomb;
var int onecount;
var int twocount;
var int threecount;
var int fourcount;
var int fivecount;
var int sixcount;

// NPC
var int npcbone1;
var int npcbone2;
var int npcbone3;
var int npcbone4;
var int npcbone5;
var int npccomb;
var int npconecount;
var int npctwocount;
var int npcthreecount;
var int npcfourcount;
var int npcfivecount;
var int npcsixcount;

// Ponowny rzut: Player
var int canrethrow;
var int rethrowfirstbone;
var int rethrowsecondbone;
var int rethrowthirdbone;
var int rethrowfourbone;
var int rethrowfivebone;

// Ponowny rzut: NPC
var int npcbone1rethrow;
var int npcbone2rethrow;
var int npcbone3rethrow;
var int npcbone4rethrow;
var int npcbone5rethrow;

// Stawka
var int stavka;
var int madestavka;
var int canmadestavka;
var int addstavka;
var int madeaddstavka;
var string playercombination;
var string npccombination;
var string lowstavkatext;
var string midstavkatext;
var string highstavkatext;
var string veryhighstavkatext;

// Pieni¹dze u Hazardzisty
var int Poker_Gambler_GoldInPocket; // Aktualna iloœæ

// Pocz¹tkowo iloœæ pieniêdzy u Hazardzisty miêdzy walkami na oficjalnych arenach, po zostaniu gladiatorem.
const int POKER_GAMBLER_GOLDINPOCKET_NONE = 0;
const int POKER_GAMBLER_GOLDINPOCKET_GLADIATORSBAY = 100;
const int POKER_GAMBLER_GOLDINPOCKET_VILLAGEARENA = 220;
const int POKER_GAMBLER_GOLDINPOCKET_FORESTARENA = 340;
const int POKER_GAMBLER_GOLDINPOCKET_CITYARENA = 460;

// Rezultat
var int musttellresult;
var int gameresult;
var int guardplayresult;
var int guardwonmoney;
var int guardlostmoney;

var int STARTPOCKERMATCH;
var int ISINDIALOG;
var C_NPC POCKERENEMY;

// Osi¹gniêcia
var int PlayerGames_Played_Counter;     // Ile razy gracz gra³ w pokera.
var int PlayerGames_Won_Counter;        // Ile razy gracz wygra³ w pokera.
var int PlayerGames_Failure_Counter;    // Ile razy gracz przegra³ w pokera.


// ===============================
// ===        FUNCTIONS        ===
// ===============================
/**
 *  Ustalanie pocz¹tkowej iloœci pieniêdzy u Hazardzisty
 *
 *  Funkcja ta jest wywo³ywana w dialogu `DIA_Hazardzista_HELLO1`
 *  oraz po ka¿dej walce na oficjalnej arenie, odbytej po zostaniu gladiatorem.
 */
func void Poker_Gambler_FillPocket() {
    if (GLADIATORSBAY == CurrentLevel) {
        Poker_Gambler_GoldInPocket = POKER_GAMBLER_GOLDINPOCKET_GLADIATORSBAY;
    } else if (VILLAGEARENA == CurrentLevel) {
        Poker_Gambler_GoldInPocket = POKER_GAMBLER_GOLDINPOCKET_VILLAGEARENA;
    } else if (FORESTARENA == CurrentLevel) {
        Poker_Gambler_GoldInPocket = POKER_GAMBLER_GOLDINPOCKET_FORESTARENA;
    } else if (CITYARENA == CurrentLevel) {
        Poker_Gambler_GoldInPocket = POKER_GAMBLER_GOLDINPOCKET_CITYARENA;
    } else {
        Poker_Gambler_GoldInPocket = POKER_GAMBLER_GOLDINPOCKET_NONE;
    };
};

// Ustalanie iloœci pieniêdzy u Hazardzisty po grze.
func void Poker_Gambler_UpdatePocket(var int money) {
    Poker_Gambler_GoldInPocket += money; 
};

func void countcombination()
{
	if(PLAYERTURN == TRUE)
	{
		PLAYERCOMB = 0;
		PLAYERCOMBINATION = "";
		if(PLAYERCOMB == 0)
		{
			if((ONECOUNT == 3) || (TWOCOUNT == 3) || (THREECOUNT == 3) || (FOURCOUNT == 3) || (FIVECOUNT == 3) || (SIXCOUNT == 3))
			{
				if(ONECOUNT == 3)
				{
					if(TWOCOUNT == 2)
					{
                        PLAYERCOMBINATION = STR_format_II(POKER_MES_FULL, 1, 2);
						PLAYERCOMB = 24;
					}
					else if(THREECOUNT == 2)
					{
						PLAYERCOMBINATION = STR_format_II(POKER_MES_FULL, 1, 3);
						PLAYERCOMB = 21;
					}
					else if(FOURCOUNT == 2)
					{
						PLAYERCOMBINATION = STR_format_II(POKER_MES_FULL, 1, 4);
						PLAYERCOMB = 26;
					}
					else if(FIVECOUNT == 2)
					{
						PLAYERCOMBINATION = STR_format_II(POKER_MES_FULL, 1, 5);
						PLAYERCOMB = 27;
					}
					else if(SIXCOUNT == 2)
					{
						PLAYERCOMBINATION = STR_format_II(POKER_MES_FULL, 1, 6);
						PLAYERCOMB = 28;
					}
					else
					{
                        PLAYERCOMBINATION = STR_format_I(POKER_MES_THREE, 1);
						PLAYERCOMB = 16;
					};
				}
				else if(TWOCOUNT == 3)
				{
					if(ONECOUNT == 2)
					{
						PLAYERCOMBINATION = STR_format_II(POKER_MES_FULL, 2, 1);
						PLAYERCOMB = 24;
					}
					else if(THREECOUNT == 2)
					{
						PLAYERCOMBINATION = STR_format_II(POKER_MES_FULL, 2, 3);
						PLAYERCOMB = 26;
					}
					else if(FOURCOUNT == 2)
					{
						PLAYERCOMBINATION = STR_format_II(POKER_MES_FULL, 2, 4);
						PLAYERCOMB = 27;
					}
					else if(FIVECOUNT == 2)
					{
						PLAYERCOMBINATION = STR_format_II(POKER_MES_FULL, 2, 5);
						PLAYERCOMB = 28;
					}
					else if(SIXCOUNT == 2)
					{
						PLAYERCOMBINATION = STR_format_II(POKER_MES_FULL, 2, 6);
						PLAYERCOMB = 29;
					}
					else
					{
						PLAYERCOMBINATION = STR_format_I(POKER_MES_THREE, 2);
						PLAYERCOMB = 17;
					};
				}
				else if(THREECOUNT == 3)
				{
					if(ONECOUNT == 2)
					{
						PLAYERCOMBINATION = STR_format_II(POKER_MES_FULL, 3, 1);
						PLAYERCOMB = 21;
					}
					else if(TWOCOUNT == 2)
					{
						PLAYERCOMBINATION = STR_format_II(POKER_MES_FULL, 3, 2);
						PLAYERCOMB = 26;
					}
					else if(FOURCOUNT == 2)
					{
						PLAYERCOMBINATION = STR_format_II(POKER_MES_FULL, 3, 4);
						PLAYERCOMB = 28;
					}
					else if(FIVECOUNT == 2)
					{
						PLAYERCOMBINATION = STR_format_II(POKER_MES_FULL, 3, 5);
						PLAYERCOMB = 29;
					}
					else if(SIXCOUNT == 2)
					{
						PLAYERCOMBINATION = STR_format_II(POKER_MES_FULL, 3, 6);
						PLAYERCOMB = 30;
					}
					else
					{
						PLAYERCOMBINATION = STR_format_I(POKER_MES_THREE, 3);
						PLAYERCOMB = 18;
					};
				}
				else if(FOURCOUNT == 3)
				{
					if(ONECOUNT == 2)
					{
						PLAYERCOMBINATION = STR_format_II(POKER_MES_FULL, 4, 1);
						PLAYERCOMB = 26;
					}
					else if(TWOCOUNT == 2)
					{
						PLAYERCOMBINATION = STR_format_II(POKER_MES_FULL, 4, 2);
						PLAYERCOMB = 27;
					}
					else if(THREECOUNT == 2)
					{
						PLAYERCOMBINATION = STR_format_II(POKER_MES_FULL, 4, 3);
						PLAYERCOMB = 28;
					}
					else if(FIVECOUNT == 2)
					{
						PLAYERCOMBINATION = STR_format_II(POKER_MES_FULL, 4, 5);
						PLAYERCOMB = 30;
					}
					else if(SIXCOUNT == 2)
					{
						PLAYERCOMBINATION = STR_format_II(POKER_MES_FULL, 4, 6);
						PLAYERCOMB = 31;
					}
					else
					{
						PLAYERCOMBINATION = STR_format_I(POKER_MES_THREE, 4);
						PLAYERCOMB = 19;
					};
				}
				else if(FIVECOUNT == 3)
				{
					if(ONECOUNT == 2)
					{
						PLAYERCOMBINATION = STR_format_II(POKER_MES_FULL, 5, 1);
						PLAYERCOMB = 27;
					}
					else if(TWOCOUNT == 2)
					{
						PLAYERCOMBINATION = STR_format_II(POKER_MES_FULL, 5, 2);
						PLAYERCOMB = 28;
					}
					else if(THREECOUNT == 2)
					{
						PLAYERCOMBINATION = STR_format_II(POKER_MES_FULL, 5, 3);
						PLAYERCOMB = 29;
					}
					else if(FOURCOUNT == 2)
					{
						PLAYERCOMBINATION = STR_format_II(POKER_MES_FULL, 5, 4);
						PLAYERCOMB = 30;
					}
					else if(SIXCOUNT == 2)
					{
						PLAYERCOMBINATION = STR_format_II(POKER_MES_FULL, 5, 6);
						PLAYERCOMB = 32;
					}
					else
					{
						PLAYERCOMBINATION = STR_format_I(POKER_MES_THREE, 5);
						PLAYERCOMB = 20;
					};
				}
				else if(ONECOUNT == 2)
				{
					PLAYERCOMBINATION = STR_format_II(POKER_MES_FULL, 6, 1);
					PLAYERCOMB = 28;
				}
				else if(TWOCOUNT == 2)
				{
					PLAYERCOMBINATION = STR_format_II(POKER_MES_FULL, 6, 2);
					PLAYERCOMB = 29;
				}
				else if(THREECOUNT == 2)
				{
					PLAYERCOMBINATION = STR_format_II(POKER_MES_FULL, 6, 3);
					PLAYERCOMB = 30;
				}
				else if(FOURCOUNT == 2)
				{
					PLAYERCOMBINATION = STR_format_II(POKER_MES_FULL, 6, 4);
					PLAYERCOMB = 31;
				}
				else if(FIVECOUNT == 2)
				{
					PLAYERCOMBINATION = STR_format_II(POKER_MES_FULL, 6, 5);
					PLAYERCOMB = 32;
				}
				else
				{
					PLAYERCOMBINATION = STR_format_I(POKER_MES_THREE, 6);
					PLAYERCOMB = 21;
				};
			};
		};
		if(PLAYERCOMB == 0)
		{
			if((ONECOUNT == 2) || (TWOCOUNT == 2) || (THREECOUNT == 2) || (FOURCOUNT == 2) || (FIVECOUNT == 2) || (SIXCOUNT == 2))
			{
				if(ONECOUNT == 2)
				{
					if(TWOCOUNT == 2)
					{
                        PLAYERCOMBINATION = STR_format_II(POKER_MES_PAIRS, 1, 2);
						PLAYERCOMB = 7;
					}
					else if(THREECOUNT == 2)
					{
						PLAYERCOMBINATION = STR_format_II(POKER_MES_PAIRS, 1, 3);
						PLAYERCOMB = 8;
					}
					else if(FOURCOUNT == 2)
					{
						PLAYERCOMBINATION = STR_format_II(POKER_MES_PAIRS, 1, 4);
						PLAYERCOMB = 9;
					}
					else if(FIVECOUNT == 2)
					{
						PLAYERCOMBINATION = STR_format_II(POKER_MES_PAIRS, 1, 5);
						PLAYERCOMB = 10;
					}
					else if(SIXCOUNT == 2)
					{
						PLAYERCOMBINATION = STR_format_II(POKER_MES_PAIRS, 1, 6);
						PLAYERCOMB = 11;
					}
					else
					{
						PLAYERCOMBINATION = STR_format_I(POKER_MES_PAIR, 1);
						PLAYERCOMB = 1;
					};
				}
				else if(TWOCOUNT == 2)
				{
					if(THREECOUNT == 2)
					{
						PLAYERCOMBINATION = STR_format_II(POKER_MES_PAIRS, 2, 3);
						PLAYERCOMB = 9;
					}
					else if(FOURCOUNT == 2)
					{
						PLAYERCOMBINATION = STR_format_II(POKER_MES_PAIRS, 2, 4);
						PLAYERCOMB = 10;
					}
					else if(FIVECOUNT == 2)
					{
						PLAYERCOMBINATION = STR_format_II(POKER_MES_PAIRS, 2, 5);
						PLAYERCOMB = 11;
					}
					else if(SIXCOUNT == 2)
					{
						PLAYERCOMBINATION = STR_format_II(POKER_MES_PAIRS, 2, 6);
						PLAYERCOMB = 12;
					}
					else
					{
						PLAYERCOMBINATION = STR_format_I(POKER_MES_PAIR, 2);
						PLAYERCOMB = 2;
					};
				}
				else if(THREECOUNT == 2)
				{
					if(FOURCOUNT == 2)
					{
						PLAYERCOMBINATION = STR_format_II(POKER_MES_PAIRS, 3, 4);
						PLAYERCOMB = 11;
					}
					else if(FIVECOUNT == 2)
					{
						PLAYERCOMBINATION = STR_format_II(POKER_MES_PAIRS, 3, 5);
						PLAYERCOMB = 12;
					}
					else if(SIXCOUNT == 2)
					{
						PLAYERCOMBINATION = STR_format_II(POKER_MES_PAIRS, 3, 6);
						PLAYERCOMB = 13;
					}
					else
					{
						PLAYERCOMBINATION = STR_format_I(POKER_MES_PAIR, 3);
						PLAYERCOMB = 3;
					};
				}
				else if(FOURCOUNT == 2)
				{
					if(FIVECOUNT == 2)
					{
						PLAYERCOMBINATION = STR_format_II(POKER_MES_PAIRS, 4, 5);
						PLAYERCOMB = 13;
					}
					else if(SIXCOUNT == 2)
					{
						PLAYERCOMBINATION = STR_format_II(POKER_MES_PAIRS, 4, 6);
						PLAYERCOMB = 14;
					}
					else
					{
						PLAYERCOMBINATION = STR_format_I(POKER_MES_PAIR, 4);
						PLAYERCOMB = 4;
					};
				}
				else if(FIVECOUNT == 2)
				{
					if(SIXCOUNT == 2)
					{
						PLAYERCOMBINATION = STR_format_II(POKER_MES_PAIRS, 5, 6);
						PLAYERCOMB = 15;
					}
					else
					{
						PLAYERCOMBINATION = STR_format_I(POKER_MES_PAIR, 5);
						PLAYERCOMB = 5;
					};
				}
				else if(SIXCOUNT == 2)
				{
					PLAYERCOMBINATION = STR_format_I(POKER_MES_PAIR, 6);
					PLAYERCOMB = 6;
				};
			};
		};
		if(PLAYERCOMB == 0)
		{
			if((ONECOUNT == 1) && (TWOCOUNT == 1) && (THREECOUNT == 1) && (FOURCOUNT == 1) && (FIVECOUNT == 1))
			{
				PLAYERCOMBINATION = POKER_SMALL_STREET;
				PLAYERCOMB = 22;
			};
		};
		if(PLAYERCOMB == 0)
		{
			if((TWOCOUNT == 1) && (THREECOUNT == 1) && (FOURCOUNT == 1) && (FIVECOUNT == 1) && (SIXCOUNT == 1))
			{
				PLAYERCOMBINATION = POKER_BIG_STREET;
				PLAYERCOMB = 23;
			};
		};
		if(PLAYERCOMB == 0)
		{
			if((ONECOUNT == 4) || (TWOCOUNT == 4) || (THREECOUNT == 4) || (FOURCOUNT == 4) || (FIVECOUNT == 4) || (SIXCOUNT == 4))
			{
				if(ONECOUNT == 4)
				{
					PLAYERCOMBINATION = STR_format_I(POKER_QUAD_OF, 1);
					PLAYERCOMB = 33;
				}
				else if(TWOCOUNT == 4)
				{
					PLAYERCOMBINATION = STR_format_I(POKER_QUAD_OF, 2);
					PLAYERCOMB = 34;
				}
				else if(THREECOUNT == 4)
				{
					PLAYERCOMBINATION = STR_format_I(POKER_QUAD_OF, 3);
					PLAYERCOMB = 35;
				}
				else if(FOURCOUNT == 4)
				{
					PLAYERCOMBINATION = STR_format_I(POKER_QUAD_OF, 4);
					PLAYERCOMB = 36;
				}
				else if(FIVECOUNT == 4)
				{
					PLAYERCOMBINATION = STR_format_I(POKER_QUAD_OF, 5);
					PLAYERCOMB = 37;
				}
				else
				{
					PLAYERCOMBINATION = STR_format_I(POKER_QUAD_OF, 6);
					PLAYERCOMB = 38;
				};
			};
		};
		if(PLAYERCOMB == 0)
		{
			if((ONECOUNT == 5) || (TWOCOUNT == 5) || (THREECOUNT == 5) || (FOURCOUNT == 5) || (FIVECOUNT == 5) || (SIXCOUNT == 5))
			{
				if(ONECOUNT == 5)
				{
                    PLAYERCOMBINATION = STR_format_I(POKER_MES_POKER, 1);
					PLAYERCOMB = 39;
				}
				else if(TWOCOUNT == 5)
				{
					PLAYERCOMBINATION = STR_format_I(POKER_MES_POKER, 2);
					PLAYERCOMB = 40;
				}
				else if(THREECOUNT == 5)
				{
					PLAYERCOMBINATION = STR_format_I(POKER_MES_POKER, 3);
					PLAYERCOMB = 41;
				}
				else if(FOURCOUNT == 5)
				{
					PLAYERCOMBINATION = STR_format_I(POKER_MES_POKER, 4);
					PLAYERCOMB = 42;
				}
				else if(FIVECOUNT == 5)
				{
					PLAYERCOMBINATION = STR_format_I(POKER_MES_POKER, 5);
					PLAYERCOMB = 43;
				}
				else
				{
					PLAYERCOMBINATION = STR_format_I(POKER_MES_POKER, 6);
					PLAYERCOMB = 44;
				};
			};
		};
		if(PLAYERCOMB == 0)
		{
            PLAYERCOMBINATION = POKER_MES_NOTHING;
		};
        var string s; s = STR_format_S(POKER_MES_PLAYER_COMBINATION, PLAYERCOMBINATION);
		PrintScreen(s,41,68,FONT_ScreenSmall,100);
	}
	else
	{
		NPCCOMB = 0;
		NPCCOMBINATION = "";
		if(NPCCOMB == 0)
		{
			if((NPCONECOUNT == 3) || (NPCTWOCOUNT == 3) || (NPCTHREECOUNT == 3) || (NPCFOURCOUNT == 3) || (NPCFIVECOUNT == 3) || (NPCSIXCOUNT == 3))
			{
				if(NPCONECOUNT == 3)
				{
					if(NPCTWOCOUNT == 2)
					{
						NPCCOMBINATION = STR_format_II(POKER_MES_FULL, 1, 2);
						NPCCOMB = 24;
					}
					else if(NPCTHREECOUNT == 2)
					{
						NPCCOMBINATION = STR_format_II(POKER_MES_FULL, 1, 3);
						NPCCOMB = 21;
					}
					else if(NPCFOURCOUNT == 2)
					{
						NPCCOMBINATION = STR_format_II(POKER_MES_FULL, 1, 4);
						NPCCOMB = 26;
					}
					else if(NPCFIVECOUNT == 2)
					{
						NPCCOMBINATION = STR_format_II(POKER_MES_FULL, 1, 5);
						NPCCOMB = 27;
					}
					else if(NPCSIXCOUNT == 2)
					{
						NPCCOMBINATION = STR_format_II(POKER_MES_FULL, 1, 6);
						NPCCOMB = 28;
					}
					else
					{
						NPCCOMBINATION = STR_format_I(POKER_MES_THREE, 1);
						NPCCOMB = 16;
					};
				}
				else if(NPCTWOCOUNT == 3)
				{
					if(NPCONECOUNT == 2)
					{
						NPCCOMBINATION = STR_format_II(POKER_MES_FULL, 2, 1);
						NPCCOMB = 24;
					}
					else if(NPCTHREECOUNT == 2)
					{
						NPCCOMBINATION = STR_format_II(POKER_MES_FULL, 2, 3);
						NPCCOMB = 26;
					}
					else if(NPCFOURCOUNT == 2)
					{
						NPCCOMBINATION = STR_format_II(POKER_MES_FULL, 2, 4);
						NPCCOMB = 27;
					}
					else if(NPCFIVECOUNT == 2)
					{
						NPCCOMBINATION = STR_format_II(POKER_MES_FULL, 2, 5);
						NPCCOMB = 28;
					}
					else if(NPCSIXCOUNT == 2)
					{
						NPCCOMBINATION = STR_format_II(POKER_MES_FULL, 2, 6);
						NPCCOMB = 29;
					}
					else
					{
						NPCCOMBINATION = STR_format_I(POKER_MES_THREE, 2);
						NPCCOMB = 17;
					};
				}
				else if(NPCTHREECOUNT == 3)
				{
					if(NPCONECOUNT == 2)
					{
						NPCCOMBINATION = STR_format_II(POKER_MES_FULL, 3, 1);
						NPCCOMB = 21;
					}
					else if(NPCTWOCOUNT == 2)
					{
						NPCCOMBINATION = STR_format_II(POKER_MES_FULL, 3, 2);
						NPCCOMB = 26;
					}
					else if(NPCFOURCOUNT == 2)
					{
						NPCCOMBINATION = STR_format_II(POKER_MES_FULL, 3, 4);
						NPCCOMB = 28;
					}
					else if(NPCFIVECOUNT == 2)
					{
						NPCCOMBINATION = STR_format_II(POKER_MES_FULL, 3, 5);
						NPCCOMB = 29;
					}
					else if(NPCSIXCOUNT == 2)
					{
						NPCCOMBINATION = STR_format_II(POKER_MES_FULL, 3, 6);
						NPCCOMB = 30;
					}
					else
					{
						NPCCOMBINATION = STR_format_I(POKER_MES_THREE, 3);
						NPCCOMB = 18;
					};
				}
				else if(NPCFOURCOUNT == 3)
				{
					if(NPCONECOUNT == 2)
					{
						NPCCOMBINATION = STR_format_II(POKER_MES_FULL, 4, 1);
						NPCCOMB = 26;
					}
					else if(NPCTWOCOUNT == 2)
					{
						NPCCOMBINATION = STR_format_II(POKER_MES_FULL, 4, 2);
						NPCCOMB = 27;
					}
					else if(NPCTHREECOUNT == 2)
					{
						NPCCOMBINATION = STR_format_II(POKER_MES_FULL, 4, 3);
						NPCCOMB = 28;
					}
					else if(NPCFIVECOUNT == 2)
					{
						NPCCOMBINATION = STR_format_II(POKER_MES_FULL, 4, 5);
						NPCCOMB = 30;
					}
					else if(NPCSIXCOUNT == 2)
					{
						NPCCOMBINATION = STR_format_II(POKER_MES_FULL, 4, 6);
						NPCCOMB = 31;
					}
					else
					{
						NPCCOMBINATION = STR_format_I(POKER_MES_THREE, 4);
						NPCCOMB = 19;
					};
				}
				else if(NPCFIVECOUNT == 3)
				{
					if(NPCONECOUNT == 2)
					{
						NPCCOMBINATION = STR_format_II(POKER_MES_FULL, 5, 1);
						NPCCOMB = 27;
					}
					else if(NPCTWOCOUNT == 2)
					{
						NPCCOMBINATION = STR_format_II(POKER_MES_FULL, 5, 2);
						NPCCOMB = 28;
					}
					else if(NPCTHREECOUNT == 2)
					{
						NPCCOMBINATION = STR_format_II(POKER_MES_FULL, 5, 3);
						NPCCOMB = 29;
					}
					else if(NPCFOURCOUNT == 2)
					{
						NPCCOMBINATION = STR_format_II(POKER_MES_FULL, 5, 4);
						NPCCOMB = 30;
					}
					else if(NPCSIXCOUNT == 2)
					{
						NPCCOMBINATION = STR_format_II(POKER_MES_FULL, 5, 6);
						NPCCOMB = 32;
					}
					else
					{
						NPCCOMBINATION = STR_format_I(POKER_MES_THREE, 5);
						NPCCOMB = 20;
					};
				}
				else if(NPCONECOUNT == 2)
				{
					NPCCOMBINATION = STR_format_II(POKER_MES_FULL, 6, 1);
					NPCCOMB = 28;
				}
				else if(NPCTWOCOUNT == 2)
				{
					NPCCOMBINATION = STR_format_II(POKER_MES_FULL, 6, 2);
					NPCCOMB = 29;
				}
				else if(NPCTHREECOUNT == 2)
				{
					NPCCOMBINATION = STR_format_II(POKER_MES_FULL, 6, 3);
					NPCCOMB = 30;
				}
				else if(NPCFOURCOUNT == 2)
				{
					NPCCOMBINATION = STR_format_II(POKER_MES_FULL, 6, 4);
					NPCCOMB = 31;
				}
				else if(NPCFIVECOUNT == 2)
				{
					NPCCOMBINATION = STR_format_II(POKER_MES_FULL, 6, 5);
					NPCCOMB = 32;
				}
				else
				{
					NPCCOMBINATION = STR_format_I(POKER_MES_THREE, 6);
					NPCCOMB = 21;
				};
			};
		};
		if(NPCCOMB == 0)
		{
			if((NPCONECOUNT == 2) || (NPCTWOCOUNT == 2) || (NPCTHREECOUNT == 2) || (NPCFOURCOUNT == 2) || (NPCFIVECOUNT == 2) || (NPCSIXCOUNT == 2))
			{
				if(NPCONECOUNT == 2)
				{
					if(NPCTWOCOUNT == 2)
					{
						NPCCOMBINATION = STR_format_II(POKER_MES_PAIRS, 1, 2);
						NPCCOMB = 7;
					}
					else if(NPCTHREECOUNT == 2)
					{
						NPCCOMBINATION = STR_format_II(POKER_MES_PAIRS, 1, 3);
						NPCCOMB = 8;
					}
					else if(NPCFOURCOUNT == 2)
					{
						NPCCOMBINATION = STR_format_II(POKER_MES_PAIRS, 1, 4);
						NPCCOMB = 9;
					}
					else if(NPCFIVECOUNT == 2)
					{
						NPCCOMBINATION = STR_format_II(POKER_MES_PAIRS, 1, 5);
						NPCCOMB = 10;
					}
					else if(NPCSIXCOUNT == 2)
					{
						NPCCOMBINATION = STR_format_II(POKER_MES_PAIRS, 1, 6);
						NPCCOMB = 11;
					}
					else
					{
						NPCCOMBINATION = STR_format_I(POKER_MES_PAIR, 1);
						NPCCOMB = 1;
					};
				}
				else if(NPCTWOCOUNT == 2)
				{
					if(NPCTHREECOUNT == 2)
					{
						NPCCOMBINATION = STR_format_II(POKER_MES_PAIRS, 2, 3);
						NPCCOMB = 9;
					}
					else if(NPCFOURCOUNT == 2)
					{
						NPCCOMBINATION = STR_format_II(POKER_MES_PAIRS, 2, 4);
						NPCCOMB = 10;
					}
					else if(NPCFIVECOUNT == 2)
					{
						NPCCOMBINATION = STR_format_II(POKER_MES_PAIRS, 2, 5);
						NPCCOMB = 11;
					}
					else if(NPCSIXCOUNT == 2)
					{
						NPCCOMBINATION = STR_format_II(POKER_MES_PAIRS, 2, 6);
						NPCCOMB = 12;
					}
					else
					{
						NPCCOMBINATION = STR_format_I(POKER_MES_PAIR, 2);
						NPCCOMB = 2;
					};
				}
				else if(NPCTHREECOUNT == 2)
				{
					if(NPCFOURCOUNT == 2)
					{
						NPCCOMBINATION = STR_format_II(POKER_MES_PAIRS, 3, 4);
						NPCCOMB = 11;
					}
					else if(NPCFIVECOUNT == 2)
					{
						NPCCOMBINATION = STR_format_II(POKER_MES_PAIRS, 3, 5);
						NPCCOMB = 12;
					}
					else if(NPCSIXCOUNT == 2)
					{
						NPCCOMBINATION = STR_format_II(POKER_MES_PAIRS, 3, 6);
						NPCCOMB = 13;
					}
					else
					{
						NPCCOMBINATION = STR_format_I(POKER_MES_PAIR, 3);
						NPCCOMB = 3;
					};
				}
				else if(NPCFOURCOUNT == 2)
				{
					if(NPCFIVECOUNT == 2)
					{
						NPCCOMBINATION = STR_format_II(POKER_MES_PAIRS, 4, 5);
						NPCCOMB = 13;
					}
					else if(NPCSIXCOUNT == 2)
					{
						NPCCOMBINATION = STR_format_II(POKER_MES_PAIRS, 4, 6);
						NPCCOMB = 14;
					}
					else
					{
						NPCCOMBINATION = STR_format_I(POKER_MES_PAIR, 4);
						NPCCOMB = 4;
					};
				}
				else if(NPCFIVECOUNT == 2)
				{
					if(NPCSIXCOUNT == 2)
					{
						NPCCOMBINATION = STR_format_II(POKER_MES_PAIRS, 5, 6);
						NPCCOMB = 15;
					}
					else
					{
						NPCCOMBINATION = STR_format_I(POKER_MES_PAIR, 5);
						NPCCOMB = 5;
					};
				}
				else if(NPCSIXCOUNT == 2)
				{
					NPCCOMBINATION = STR_format_I(POKER_MES_PAIR, 6);
					NPCCOMB = 6;
				};
			};
		};
		if(NPCCOMB == 0)
		{
			if((NPCONECOUNT == 1) && (NPCTWOCOUNT == 1) && (NPCTHREECOUNT == 1) && (NPCFOURCOUNT == 1) && (NPCFIVECOUNT == 1))
			{
				NPCCOMBINATION = POKER_SMALL_STREET;
				NPCCOMB = 22;
			};
		};
		if(NPCCOMB == 0)
		{
			if((NPCTWOCOUNT == 1) && (NPCTHREECOUNT == 1) && (NPCFOURCOUNT == 1) && (NPCFIVECOUNT == 1) && (NPCSIXCOUNT == 1))
			{
				NPCCOMBINATION = POKER_BIG_STREET;
				NPCCOMB = 23;
			};
		};
		if(NPCCOMB == 0)
		{
			if((NPCONECOUNT == 4) || (NPCTWOCOUNT == 4) || (NPCTHREECOUNT == 4) || (NPCFOURCOUNT == 4) || (NPCFIVECOUNT == 4) || (NPCSIXCOUNT == 4))
			{
				if(NPCONECOUNT == 4)
				{
					NPCCOMBINATION = STR_format_I(POKER_QUAD_OF, 1);
					NPCCOMB = 33;
				}
				else if(NPCTWOCOUNT == 4)
				{
					NPCCOMBINATION = STR_format_I(POKER_QUAD_OF, 2);
					NPCCOMB = 34;
				}
				else if(NPCTHREECOUNT == 4)
				{
					NPCCOMBINATION = STR_format_I(POKER_QUAD_OF, 3);
					NPCCOMB = 35;
				}
				else if(NPCFOURCOUNT == 4)
				{
					NPCCOMBINATION = STR_format_I(POKER_QUAD_OF, 4);
					NPCCOMB = 36;
				}
				else if(NPCFIVECOUNT == 4)
				{
					NPCCOMBINATION = STR_format_I(POKER_QUAD_OF, 5);
					NPCCOMB = 37;
				}
				else
				{
					NPCCOMBINATION = STR_format_I(POKER_QUAD_OF, 6);
					NPCCOMB = 38;
				};
			};
		};
		if(NPCCOMB == 0)
		{
			if((NPCONECOUNT == 5) || (NPCTWOCOUNT == 5) || (NPCTHREECOUNT == 5) || (NPCFOURCOUNT == 5) || (NPCFIVECOUNT == 5) || (NPCSIXCOUNT == 5))
			{
				if(NPCONECOUNT == 5)
				{
					NPCCOMBINATION = STR_format_I(POKER_MES_POKER, 1);
					NPCCOMB = 39;
				}
				else if(NPCTWOCOUNT == 5)
				{
					NPCCOMBINATION = STR_format_I(POKER_MES_POKER, 2);
					NPCCOMB = 40;
				}
				else if(NPCTHREECOUNT == 5)
				{
					NPCCOMBINATION = STR_format_I(POKER_MES_POKER, 3);
					NPCCOMB = 41;
				}
				else if(NPCFOURCOUNT == 5)
				{
					NPCCOMBINATION = STR_format_I(POKER_MES_POKER, 4);
					NPCCOMB = 42;
				}
				else if(NPCFIVECOUNT == 5)
				{
					NPCCOMBINATION = STR_format_I(POKER_MES_POKER, 5);
					NPCCOMB = 43;
				}
				else
				{
					NPCCOMBINATION = STR_format_I(POKER_MES_POKER, 6);
					NPCCOMB = 44;
				};
			};
		};
		if(NPCCOMB == 0)
		{
			NPCCOMBINATION = POKER_MES_NOTHING;
		};
        s = STR_format_S(POKER_MES_NPC_COMBINATION, NPCCOMBINATION);
		PrintScreen(s,41,29,FONT_ScreenSmall,100);
	};
};

func void npcrethrow()
{
	NPCBONE1RETHROW = FALSE;
	NPCBONE2RETHROW = FALSE;
	NPCBONE3RETHROW = FALSE;
	NPCBONE4RETHROW = FALSE;
	NPCBONE5RETHROW = FALSE;
	if((NPCCOMB < 39) && (NPCCOMB != 22) && (NPCCOMB != 23) && (NPCCOMB != 24) && (NPCCOMB != 21) && (NPCCOMB != 26) && (NPCCOMB != 27) && (NPCCOMB != 28) && (NPCCOMB != 29) && (NPCCOMB != 30) && (NPCCOMB != 31) && (NPCCOMB != 32))
	{
		if(NPCCOMB >= 33)
		{
			if(NPCCOMB == 33)
			{
				if(NPCBONE1 != 1)
				{
					NPCBONE1RETHROW = TRUE;
				}
				else if(NPCBONE2 != 1)
				{
					NPCBONE2RETHROW = TRUE;
				}
				else if(NPCBONE3 != 1)
				{
					NPCBONE3RETHROW = TRUE;
				}
				else if(NPCBONE4 != 1)
				{
					NPCBONE4RETHROW = TRUE;
				}
				else
				{
					NPCBONE5RETHROW = TRUE;
				};
			}
			else if(NPCCOMB == 34)
			{
				if(NPCBONE1 != 2)
				{
					NPCBONE1RETHROW = TRUE;
				}
				else if(NPCBONE2 != 2)
				{
					NPCBONE2RETHROW = TRUE;
				}
				else if(NPCBONE3 != 2)
				{
					NPCBONE3RETHROW = TRUE;
				}
				else if(NPCBONE4 != 2)
				{
					NPCBONE4RETHROW = TRUE;
				}
				else
				{
					NPCBONE5RETHROW = TRUE;
				};
			}
			else if(NPCCOMB == 35)
			{
				if(NPCBONE1 != 3)
				{
					NPCBONE1RETHROW = TRUE;
				}
				else if(NPCBONE2 != 3)
				{
					NPCBONE2RETHROW = TRUE;
				}
				else if(NPCBONE3 != 3)
				{
					NPCBONE3RETHROW = TRUE;
				}
				else if(NPCBONE4 != 3)
				{
					NPCBONE4RETHROW = TRUE;
				}
				else
				{
					NPCBONE5RETHROW = TRUE;
				};
			}
			else if(NPCCOMB == 36)
			{
				if(NPCBONE1 != 4)
				{
					NPCBONE1RETHROW = TRUE;
				}
				else if(NPCBONE2 != 4)
				{
					NPCBONE2RETHROW = TRUE;
				}
				else if(NPCBONE3 != 4)
				{
					NPCBONE3RETHROW = TRUE;
				}
				else if(NPCBONE4 != 4)
				{
					NPCBONE4RETHROW = TRUE;
				}
				else
				{
					NPCBONE5RETHROW = TRUE;
				};
			}
			else if(NPCCOMB == 37)
			{
				if(NPCBONE1 != 5)
				{
					NPCBONE1RETHROW = TRUE;
				}
				else if(NPCBONE2 != 5)
				{
					NPCBONE2RETHROW = TRUE;
				}
				else if(NPCBONE3 != 5)
				{
					NPCBONE3RETHROW = TRUE;
				}
				else if(NPCBONE4 != 5)
				{
					NPCBONE4RETHROW = TRUE;
				}
				else
				{
					NPCBONE5RETHROW = TRUE;
				};
			}
			else if(NPCBONE1 != 6)
			{
				NPCBONE1RETHROW = TRUE;
			}
			else if(NPCBONE2 != 6)
			{
				NPCBONE2RETHROW = TRUE;
			}
			else if(NPCBONE3 != 6)
			{
				NPCBONE3RETHROW = TRUE;
			}
			else if(NPCBONE4 != 6)
			{
				NPCBONE4RETHROW = TRUE;
			}
			else
			{
				NPCBONE5RETHROW = TRUE;
			};
		}
		else if((NPCCOMB <= 21) && (NPCCOMB >= 16))
		{
			if(NPCCOMB == 16)
			{
				if(NPCBONE1 != 1)
				{
					NPCBONE1RETHROW = TRUE;
				};
				if(NPCBONE2 != 1)
				{
					NPCBONE2RETHROW = TRUE;
				};
				if(NPCBONE3 != 1)
				{
					NPCBONE3RETHROW = TRUE;
				};
				if(NPCBONE4 != 1)
				{
					NPCBONE4RETHROW = TRUE;
				};
				if(NPCBONE5 != 1)
				{
					NPCBONE5RETHROW = TRUE;
				};
			}
			else if(NPCCOMB == 17)
			{
				if(NPCBONE1 != 2)
				{
					NPCBONE1RETHROW = TRUE;
				};
				if(NPCBONE2 != 2)
				{
					NPCBONE2RETHROW = TRUE;
				};
				if(NPCBONE3 != 2)
				{
					NPCBONE3RETHROW = TRUE;
				};
				if(NPCBONE4 != 2)
				{
					NPCBONE4RETHROW = TRUE;
				};
				if(NPCBONE5 != 2)
				{
					NPCBONE5RETHROW = TRUE;
				};
			}
			else if(NPCCOMB == 18)
			{
				if(NPCBONE1 != 3)
				{
					NPCBONE1RETHROW = TRUE;
				};
				if(NPCBONE2 != 3)
				{
					NPCBONE2RETHROW = TRUE;
				};
				if(NPCBONE3 != 3)
				{
					NPCBONE3RETHROW = TRUE;
				};
				if(NPCBONE4 != 3)
				{
					NPCBONE4RETHROW = TRUE;
				};
				if(NPCBONE5 != 3)
				{
					NPCBONE5RETHROW = TRUE;
				};
			}
			else if(NPCCOMB == 19)
			{
				if(NPCBONE1 != 4)
				{
					NPCBONE1RETHROW = TRUE;
				};
				if(NPCBONE2 != 4)
				{
					NPCBONE2RETHROW = TRUE;
				};
				if(NPCBONE3 != 4)
				{
					NPCBONE3RETHROW = TRUE;
				};
				if(NPCBONE4 != 4)
				{
					NPCBONE4RETHROW = TRUE;
				};
				if(NPCBONE5 != 4)
				{
					NPCBONE5RETHROW = TRUE;
				};
			}
			else if(NPCCOMB == 20)
			{
				if(NPCBONE1 != 5)
				{
					NPCBONE1RETHROW = TRUE;
				};
				if(NPCBONE2 != 5)
				{
					NPCBONE2RETHROW = TRUE;
				};
				if(NPCBONE3 != 5)
				{
					NPCBONE3RETHROW = TRUE;
				};
				if(NPCBONE4 != 5)
				{
					NPCBONE4RETHROW = TRUE;
				};
				if(NPCBONE5 != 5)
				{
					NPCBONE5RETHROW = TRUE;
				};
			}
			else
			{
				if(NPCBONE1 != 6)
				{
					NPCBONE1RETHROW = TRUE;
				};
				if(NPCBONE2 != 6)
				{
					NPCBONE2RETHROW = TRUE;
				};
				if(NPCBONE3 != 6)
				{
					NPCBONE3RETHROW = TRUE;
				};
				if(NPCBONE4 != 6)
				{
					NPCBONE4RETHROW = TRUE;
				};
				if(NPCBONE5 != 6)
				{
					NPCBONE5RETHROW = TRUE;
				};
			};
		}
		else if((NPCCOMB >= 7) && (NPCCOMB <= 15))
		{
			if(NPCCOMB == 7)
			{
				if((NPCONECOUNT == 2) && (NPCTWOCOUNT == 2))
				{
					if((NPCBONE1 != 1) && (NPCBONE1 != 2))
					{
						NPCBONE1RETHROW = TRUE;
					};
					if((NPCBONE2 != 1) && (NPCBONE2 != 2))
					{
						NPCBONE2RETHROW = TRUE;
					};
					if((NPCBONE3 != 1) && (NPCBONE3 != 2))
					{
						NPCBONE3RETHROW = TRUE;
					};
					if((NPCBONE4 != 1) && (NPCBONE4 != 2))
					{
						NPCBONE4RETHROW = TRUE;
					};
					if((NPCBONE5 != 1) && (NPCBONE5 != 2))
					{
						NPCBONE5RETHROW = TRUE;
					};
				};
			}
			else if(NPCCOMB == 8)
			{
				if((NPCONECOUNT == 2) && (NPCTHREECOUNT == 2))
				{
					if((NPCBONE1 != 1) && (NPCBONE1 != 3))
					{
						NPCBONE1RETHROW = TRUE;
					};
					if((NPCBONE2 != 1) && (NPCBONE2 != 3))
					{
						NPCBONE2RETHROW = TRUE;
					};
					if((NPCBONE3 != 1) && (NPCBONE3 != 3))
					{
						NPCBONE3RETHROW = TRUE;
					};
					if((NPCBONE4 != 1) && (NPCBONE4 != 3))
					{
						NPCBONE4RETHROW = TRUE;
					};
					if((NPCBONE5 != 1) && (NPCBONE5 != 3))
					{
						NPCBONE5RETHROW = TRUE;
					};
				};
			}
			else if(NPCCOMB == 9)
			{
				if((NPCONECOUNT == 2) && (NPCFOURCOUNT == 2))
				{
					if((NPCBONE1 != 1) && (NPCBONE1 != 4))
					{
						NPCBONE1RETHROW = TRUE;
					};
					if((NPCBONE2 != 1) && (NPCBONE2 != 4))
					{
						NPCBONE2RETHROW = TRUE;
					};
					if((NPCBONE3 != 1) && (NPCBONE3 != 4))
					{
						NPCBONE3RETHROW = TRUE;
					};
					if((NPCBONE4 != 1) && (NPCBONE4 != 4))
					{
						NPCBONE4RETHROW = TRUE;
					};
					if((NPCBONE5 != 1) && (NPCBONE5 != 4))
					{
						NPCBONE5RETHROW = TRUE;
					};
				};
				if((NPCTWOCOUNT == 2) && (NPCTHREECOUNT == 2))
				{
					if((NPCBONE1 != 2) && (NPCBONE1 != 3))
					{
						NPCBONE1RETHROW = TRUE;
					};
					if((NPCBONE2 != 2) && (NPCBONE2 != 3))
					{
						NPCBONE2RETHROW = TRUE;
					};
					if((NPCBONE3 != 2) && (NPCBONE3 != 3))
					{
						NPCBONE3RETHROW = TRUE;
					};
					if((NPCBONE4 != 2) && (NPCBONE4 != 3))
					{
						NPCBONE4RETHROW = TRUE;
					};
					if((NPCBONE5 != 2) && (NPCBONE5 != 3))
					{
						NPCBONE5RETHROW = TRUE;
					};
				};
			}
			else if(NPCCOMB == 10)
			{
				if((NPCONECOUNT == 2) && (NPCFIVECOUNT == 2))
				{
					if((NPCBONE1 != 1) && (NPCBONE1 != 5))
					{
						NPCBONE1RETHROW = TRUE;
					};
					if((NPCBONE2 != 1) && (NPCBONE2 != 5))
					{
						NPCBONE2RETHROW = TRUE;
					};
					if((NPCBONE3 != 1) && (NPCBONE3 != 5))
					{
						NPCBONE3RETHROW = TRUE;
					};
					if((NPCBONE4 != 1) && (NPCBONE4 != 5))
					{
						NPCBONE4RETHROW = TRUE;
					};
					if((NPCBONE5 != 1) && (NPCBONE5 != 5))
					{
						NPCBONE5RETHROW = TRUE;
					};
				};
				if((NPCTWOCOUNT == 2) && (NPCFOURCOUNT == 2))
				{
					if((NPCBONE1 != 2) && (NPCBONE1 != 4))
					{
						NPCBONE1RETHROW = TRUE;
					};
					if((NPCBONE2 != 2) && (NPCBONE2 != 4))
					{
						NPCBONE2RETHROW = TRUE;
					};
					if((NPCBONE3 != 2) && (NPCBONE3 != 4))
					{
						NPCBONE3RETHROW = TRUE;
					};
					if((NPCBONE4 != 2) && (NPCBONE4 != 4))
					{
						NPCBONE4RETHROW = TRUE;
					};
					if((NPCBONE5 != 2) && (NPCBONE5 != 4))
					{
						NPCBONE5RETHROW = TRUE;
					};
				};
			}
			else if(NPCCOMB == 11)
			{
				if((NPCONECOUNT == 2) && (NPCSIXCOUNT == 2))
				{
					if((NPCBONE1 != 1) && (NPCBONE1 != 6))
					{
						NPCBONE1RETHROW = TRUE;
					};
					if((NPCBONE2 != 1) && (NPCBONE2 != 6))
					{
						NPCBONE2RETHROW = TRUE;
					};
					if((NPCBONE3 != 1) && (NPCBONE3 != 6))
					{
						NPCBONE3RETHROW = TRUE;
					};
					if((NPCBONE4 != 1) && (NPCBONE4 != 6))
					{
						NPCBONE4RETHROW = TRUE;
					};
					if((NPCBONE5 != 1) && (NPCBONE5 != 6))
					{
						NPCBONE5RETHROW = TRUE;
					};
				};
				if((NPCTWOCOUNT == 2) && (NPCFIVECOUNT == 2))
				{
					if((NPCBONE1 != 2) && (NPCBONE1 != 5))
					{
						NPCBONE1RETHROW = TRUE;
					};
					if((NPCBONE2 != 2) && (NPCBONE2 != 5))
					{
						NPCBONE2RETHROW = TRUE;
					};
					if((NPCBONE3 != 2) && (NPCBONE3 != 5))
					{
						NPCBONE3RETHROW = TRUE;
					};
					if((NPCBONE4 != 2) && (NPCBONE4 != 5))
					{
						NPCBONE4RETHROW = TRUE;
					};
					if((NPCBONE5 != 2) && (NPCBONE5 != 5))
					{
						NPCBONE5RETHROW = TRUE;
					};
				};
				if((NPCTHREECOUNT == 2) && (NPCFOURCOUNT == 2))
				{
					if((NPCBONE1 != 3) && (NPCBONE1 != 4))
					{
						NPCBONE1RETHROW = TRUE;
					};
					if((NPCBONE2 != 3) && (NPCBONE2 != 4))
					{
						NPCBONE2RETHROW = TRUE;
					};
					if((NPCBONE3 != 3) && (NPCBONE3 != 4))
					{
						NPCBONE3RETHROW = TRUE;
					};
					if((NPCBONE4 != 3) && (NPCBONE4 != 4))
					{
						NPCBONE4RETHROW = TRUE;
					};
					if((NPCBONE5 != 3) && (NPCBONE5 != 4))
					{
						NPCBONE5RETHROW = TRUE;
					};
				};
			}
			else if(NPCCOMB == 12)
			{
				if((NPCTWOCOUNT == 2) && (NPCSIXCOUNT == 2))
				{
					if((NPCBONE1 != 2) && (NPCBONE1 != 6))
					{
						NPCBONE1RETHROW = TRUE;
					};
					if((NPCBONE2 != 2) && (NPCBONE2 != 6))
					{
						NPCBONE2RETHROW = TRUE;
					};
					if((NPCBONE3 != 2) && (NPCBONE3 != 6))
					{
						NPCBONE3RETHROW = TRUE;
					};
					if((NPCBONE4 != 2) && (NPCBONE4 != 6))
					{
						NPCBONE4RETHROW = TRUE;
					};
					if((NPCBONE5 != 2) && (NPCBONE5 != 6))
					{
						NPCBONE5RETHROW = TRUE;
					};
				};
				if((NPCTHREECOUNT == 2) && (NPCFIVECOUNT == 2))
				{
					if((NPCBONE1 != 3) && (NPCBONE1 != 5))
					{
						NPCBONE1RETHROW = TRUE;
					};
					if((NPCBONE2 != 3) && (NPCBONE2 != 5))
					{
						NPCBONE2RETHROW = TRUE;
					};
					if((NPCBONE3 != 3) && (NPCBONE3 != 5))
					{
						NPCBONE3RETHROW = TRUE;
					};
					if((NPCBONE4 != 3) && (NPCBONE4 != 5))
					{
						NPCBONE4RETHROW = TRUE;
					};
					if((NPCBONE5 != 3) && (NPCBONE5 != 5))
					{
						NPCBONE5RETHROW = TRUE;
					};
				};
			}
			else if(NPCCOMB == 13)
			{
				if((NPCFOURCOUNT == 2) && (NPCFIVECOUNT == 2))
				{
					if((NPCBONE1 != 4) && (NPCBONE1 != 5))
					{
						NPCBONE1RETHROW = TRUE;
					};
					if((NPCBONE2 != 4) && (NPCBONE2 != 5))
					{
						NPCBONE2RETHROW = TRUE;
					};
					if((NPCBONE3 != 4) && (NPCBONE3 != 5))
					{
						NPCBONE3RETHROW = TRUE;
					};
					if((NPCBONE4 != 4) && (NPCBONE4 != 5))
					{
						NPCBONE4RETHROW = TRUE;
					};
					if((NPCBONE5 != 4) && (NPCBONE5 != 5))
					{
						NPCBONE5RETHROW = TRUE;
					};
				};
			}
			else if(NPCCOMB == 14)
			{
				if((NPCFOURCOUNT == 2) && (NPCSIXCOUNT == 2))
				{
					if((NPCBONE1 != 4) && (NPCBONE1 != 6))
					{
						NPCBONE1RETHROW = TRUE;
					};
					if((NPCBONE2 != 4) && (NPCBONE2 != 6))
					{
						NPCBONE2RETHROW = TRUE;
					};
					if((NPCBONE3 != 4) && (NPCBONE3 != 6))
					{
						NPCBONE3RETHROW = TRUE;
					};
					if((NPCBONE4 != 4) && (NPCBONE4 != 6))
					{
						NPCBONE4RETHROW = TRUE;
					};
					if((NPCBONE5 != 4) && (NPCBONE5 != 6))
					{
						NPCBONE5RETHROW = TRUE;
					};
				};
			}
			else if(NPCCOMB == 15)
			{
				if((NPCFIVECOUNT == 2) && (NPCSIXCOUNT == 2))
				{
					if((NPCBONE1 != 5) && (NPCBONE1 != 6))
					{
						NPCBONE1RETHROW = TRUE;
					};
					if((NPCBONE2 != 5) && (NPCBONE2 != 6))
					{
						NPCBONE2RETHROW = TRUE;
					};
					if((NPCBONE3 != 5) && (NPCBONE3 != 6))
					{
						NPCBONE3RETHROW = TRUE;
					};
					if((NPCBONE4 != 5) && (NPCBONE4 != 6))
					{
						NPCBONE4RETHROW = TRUE;
					};
					if((NPCBONE5 != 5) && (NPCBONE5 != 6))
					{
						NPCBONE5RETHROW = TRUE;
					};
				};
			};
		}
		else if((NPCCOMB > 0) && (NPCCOMB <= 6))
		{
			if(NPCCOMB == 1)
			{
				if(NPCBONE1 != 1)
				{
					NPCBONE1RETHROW = TRUE;
				};
				if(NPCBONE2 != 1)
				{
					NPCBONE2RETHROW = TRUE;
				};
				if(NPCBONE3 != 1)
				{
					NPCBONE3RETHROW = TRUE;
				};
				if(NPCBONE4 != 1)
				{
					NPCBONE4RETHROW = TRUE;
				};
				if(NPCBONE5 != 1)
				{
					NPCBONE5RETHROW = TRUE;
				};
			}
			else if(NPCCOMB == 2)
			{
				if(NPCBONE1 != 2)
				{
					NPCBONE1RETHROW = TRUE;
				};
				if(NPCBONE2 != 2)
				{
					NPCBONE2RETHROW = TRUE;
				};
				if(NPCBONE3 != 2)
				{
					NPCBONE3RETHROW = TRUE;
				};
				if(NPCBONE4 != 2)
				{
					NPCBONE4RETHROW = TRUE;
				};
				if(NPCBONE5 != 2)
				{
					NPCBONE5RETHROW = TRUE;
				};
			}
			else if(NPCCOMB == 3)
			{
				if(NPCBONE1 != 3)
				{
					NPCBONE1RETHROW = TRUE;
				};
				if(NPCBONE2 != 3)
				{
					NPCBONE2RETHROW = TRUE;
				};
				if(NPCBONE3 != 3)
				{
					NPCBONE3RETHROW = TRUE;
				};
				if(NPCBONE4 != 3)
				{
					NPCBONE4RETHROW = TRUE;
				};
				if(NPCBONE5 != 3)
				{
					NPCBONE5RETHROW = TRUE;
				};
			}
			else if(NPCCOMB == 4)
			{
				if(NPCBONE1 != 4)
				{
					NPCBONE1RETHROW = TRUE;
				};
				if(NPCBONE2 != 4)
				{
					NPCBONE2RETHROW = TRUE;
				};
				if(NPCBONE3 != 4)
				{
					NPCBONE3RETHROW = TRUE;
				};
				if(NPCBONE4 != 4)
				{
					NPCBONE4RETHROW = TRUE;
				};
				if(NPCBONE5 != 4)
				{
					NPCBONE5RETHROW = TRUE;
				};
			}
			else if(NPCCOMB == 5)
			{
				if(NPCBONE1 != 5)
				{
					NPCBONE1RETHROW = TRUE;
				};
				if(NPCBONE2 != 5)
				{
					NPCBONE2RETHROW = TRUE;
				};
				if(NPCBONE3 != 5)
				{
					NPCBONE3RETHROW = TRUE;
				};
				if(NPCBONE4 != 5)
				{
					NPCBONE4RETHROW = TRUE;
				};
				if(NPCBONE5 != 5)
				{
					NPCBONE5RETHROW = TRUE;
				};
			}
			else
			{
				if(NPCBONE1 != 6)
				{
					NPCBONE1RETHROW = TRUE;
				};
				if(NPCBONE2 != 6)
				{
					NPCBONE2RETHROW = TRUE;
				};
				if(NPCBONE3 != 6)
				{
					NPCBONE3RETHROW = TRUE;
				};
				if(NPCBONE4 != 6)
				{
					NPCBONE4RETHROW = TRUE;
				};
				if(NPCBONE5 != 6)
				{
					NPCBONE5RETHROW = TRUE;
				};
			};
		};
	}
	else
	{
	};
};

func void throw1bone()
{
	if(PLAYERTURN == TRUE)
	{
		PLAYERBONE1 = Hlp_Random(5);
		PLAYERBONE1 += 1;
		if(PLAYERBONE1 == 1)
		{
			ONECOUNT += 1;
		};
		if(PLAYERBONE1 == 2)
		{
			TWOCOUNT += 1;
		};
		if(PLAYERBONE1 == 3)
		{
			THREECOUNT += 1;
		};
		if(PLAYERBONE1 == 4)
		{
			FOURCOUNT += 1;
		};
		if(PLAYERBONE1 == 5)
		{
			FIVECOUNT += 1;
		};
		if(PLAYERBONE1 == 6)
		{
			SIXCOUNT += 1;
		};
		PrintScreen(IntToString(PLAYERBONE1),30,71,FONT_SYMBOLS,100);
	}
	else
	{
		NPCBONE1 = Hlp_Random(5);
		NPCBONE1 += 1;
		if(NPCBONE1 == 1)
		{
			NPCONECOUNT += 1;
		};
		if(NPCBONE1 == 2)
		{
			NPCTWOCOUNT += 1;
		};
		if(NPCBONE1 == 3)
		{
			NPCTHREECOUNT += 1;
		};
		if(NPCBONE1 == 4)
		{
			NPCFOURCOUNT += 1;
		};
		if(NPCBONE1 == 5)
		{
			NPCFIVECOUNT += 1;
		};
		if(NPCBONE1 == 6)
		{
			NPCSIXCOUNT += 1;
		};
		PrintScreen(IntToString(NPCBONE1),30,21,FONT_SYMBOLS,100);
	};
};

func void throw2bone()
{
	if(PLAYERTURN == TRUE)
	{
		PLAYERBONE2 = Hlp_Random(5);
		PLAYERBONE2 += 1;
		if(PLAYERBONE2 == 1)
		{
			ONECOUNT += 1;
		};
		if(PLAYERBONE2 == 2)
		{
			TWOCOUNT += 1;
		};
		if(PLAYERBONE2 == 3)
		{
			THREECOUNT += 1;
		};
		if(PLAYERBONE2 == 4)
		{
			FOURCOUNT += 1;
		};
		if(PLAYERBONE2 == 5)
		{
			FIVECOUNT += 1;
		};
		if(PLAYERBONE2 == 6)
		{
			SIXCOUNT += 1;
		};
		PrintScreen(IntToString(PLAYERBONE2),39,71,FONT_SYMBOLS,100);
	}
	else
	{
		NPCBONE2 = Hlp_Random(5);
		NPCBONE2 += 1;
		if(NPCBONE2 == 1)
		{
			NPCONECOUNT += 1;
		};
		if(NPCBONE2 == 2)
		{
			NPCTWOCOUNT += 1;
		};
		if(NPCBONE2 == 3)
		{
			NPCTHREECOUNT += 1;
		};
		if(NPCBONE2 == 4)
		{
			NPCFOURCOUNT += 1;
		};
		if(NPCBONE2 == 5)
		{
			NPCFIVECOUNT += 1;
		};
		if(NPCBONE2 == 6)
		{
			NPCSIXCOUNT += 1;
		};
		PrintScreen(IntToString(NPCBONE2),39,21,FONT_SYMBOLS,100);
	};
};

func void throw3bone()
{
	if(PLAYERTURN == TRUE)
	{
		PLAYERBONE3 = Hlp_Random(5);
		PLAYERBONE3 += 1;
		if(PLAYERBONE3 == 1)
		{
			ONECOUNT += 1;
		};
		if(PLAYERBONE3 == 2)
		{
			TWOCOUNT += 1;
		};
		if(PLAYERBONE3 == 3)
		{
			THREECOUNT += 1;
		};
		if(PLAYERBONE3 == 4)
		{
			FOURCOUNT += 1;
		};
		if(PLAYERBONE3 == 5)
		{
			FIVECOUNT += 1;
		};
		if(PLAYERBONE3 == 6)
		{
			SIXCOUNT += 1;
		};
		PrintScreen(IntToString(PLAYERBONE3),48,71,FONT_SYMBOLS,100);
	}
	else
	{
		NPCBONE3 = Hlp_Random(5);
		NPCBONE3 += 1;
		if(NPCBONE3 == 1)
		{
			NPCONECOUNT += 1;
		};
		if(NPCBONE3 == 2)
		{
			NPCTWOCOUNT += 1;
		};
		if(NPCBONE3 == 3)
		{
			NPCTHREECOUNT += 1;
		};
		if(NPCBONE3 == 4)
		{
			NPCFOURCOUNT += 1;
		};
		if(NPCBONE3 == 5)
		{
			NPCFIVECOUNT += 1;
		};
		if(NPCBONE3 == 6)
		{
			NPCSIXCOUNT += 1;
		};
		PrintScreen(IntToString(NPCBONE3),48,21,FONT_SYMBOLS,100);
	};
};

func void throw4bone()
{
	if(PLAYERTURN == TRUE)
	{
		PLAYERBONE4 = Hlp_Random(5);
		PLAYERBONE4 += 1;
		if(PLAYERBONE4 == 1)
		{
			ONECOUNT += 1;
		};
		if(PLAYERBONE4 == 2)
		{
			TWOCOUNT += 1;
		};
		if(PLAYERBONE4 == 3)
		{
			THREECOUNT += 1;
		};
		if(PLAYERBONE4 == 4)
		{
			FOURCOUNT += 1;
		};
		if(PLAYERBONE4 == 5)
		{
			FIVECOUNT += 1;
		};
		if(PLAYERBONE4 == 6)
		{
			SIXCOUNT += 1;
		};
		PrintScreen(IntToString(PLAYERBONE4),57,71,FONT_SYMBOLS,100);
	}
	else
	{
		NPCBONE4 = Hlp_Random(5);
		NPCBONE4 += 1;
		if(NPCBONE4 == 1)
		{
			NPCONECOUNT += 1;
		};
		if(NPCBONE4 == 2)
		{
			NPCTWOCOUNT += 1;
		};
		if(NPCBONE4 == 3)
		{
			NPCTHREECOUNT += 1;
		};
		if(NPCBONE4 == 4)
		{
			NPCFOURCOUNT += 1;
		};
		if(NPCBONE4 == 5)
		{
			NPCFIVECOUNT += 1;
		};
		if(NPCBONE4 == 6)
		{
			NPCSIXCOUNT += 1;
		};
		PrintScreen(IntToString(NPCBONE4),57,21,FONT_SYMBOLS,100);
	};
};

func void throw5bone()
{
	if(PLAYERTURN == TRUE)
	{
		PLAYERBONE5 = Hlp_Random(5);
		PLAYERBONE5 += 1;
		if(PLAYERBONE5 == 1)
		{
			ONECOUNT += 1;
		};
		if(PLAYERBONE5 == 2)
		{
			TWOCOUNT += 1;
		};
		if(PLAYERBONE5 == 3)
		{
			THREECOUNT += 1;
		};
		if(PLAYERBONE5 == 4)
		{
			FOURCOUNT += 1;
		};
		if(PLAYERBONE5 == 5)
		{
			FIVECOUNT += 1;
		};
		if(PLAYERBONE5 == 6)
		{
			SIXCOUNT += 1;
		};
		PrintScreen(IntToString(PLAYERBONE5),66,71,FONT_SYMBOLS,100);
	}
	else
	{
		NPCBONE5 = Hlp_Random(5);
		NPCBONE5 += 1;
		if(NPCBONE5 == 1)
		{
			NPCONECOUNT += 1;
		};
		if(NPCBONE5 == 2)
		{
			NPCTWOCOUNT += 1;
		};
		if(NPCBONE5 == 3)
		{
			NPCTHREECOUNT += 1;
		};
		if(NPCBONE5 == 4)
		{
			NPCFOURCOUNT += 1;
		};
		if(NPCBONE5 == 5)
		{
			NPCFIVECOUNT += 1;
		};
		if(NPCBONE5 == 6)
		{
			NPCSIXCOUNT += 1;
		};
		PrintScreen(IntToString(NPCBONE5),66,21,FONT_SYMBOLS,100);
	};
};

func void throwbones()
{
	throw1bone();
	throw2bone();
	throw3bone();
	throw4bone();
	throw5bone();
	countcombination();
};

func void endpocker()
{
	AI_StopProcessInfos(self);
	hero.aivar[AIV_INVINCIBLE] = FALSE;
	PLAYER_MOBSI_PRODUCTION = MOBSI_NONE;
	Wld_StopEffect("POCKERTABLE");
	STARTPOCKERMATCH = 0;
	ISINDIALOG = 0;
	MADEADDSTAVKA = 0;
	MADESTAVKA = 0;
	ADDSTAVKA = 0;
    if (0 != GAMERESULT) {
        MUSTTELLRESULT = TRUE;
        // ACHIEVEMENT: 100 rozegranych gier
        PlayerGames_Played_Counter += 1;
        if (100 == PlayerGames_Played_Counter) {
            Achievement_RequestHandle(ACHIEVEMENT_POKER_100GAMES);
        };
    };
	PLAYERCOMBINATION = "";
    PLAYERCOMBINATION = "";
	NPCCOMBINATION = "";
	PrintScreen(PLAYERCOMBINATION,41,68,FONT_ScreenSmall,100);
	PrintScreen(NPCCOMBINATION,41,29,FONT_ScreenSmall,100);
	PrintScreen("",30,71,FONT_SYMBOLS,100);
	PrintScreen("",39,71,FONT_SYMBOLS,100);
	PrintScreen("",48,71,FONT_SYMBOLS,100);
	PrintScreen("",57,71,FONT_SYMBOLS,100);
	PrintScreen("",66,71,FONT_SYMBOLS,100);
	PrintScreen("",30,21,FONT_SYMBOLS,100);
	PrintScreen("",39,21,FONT_SYMBOLS,100);
	PrintScreen("",48,21,FONT_SYMBOLS,100);
	PrintScreen("",57,21,FONT_SYMBOLS,100);
	PrintScreen("",66,21,FONT_SYMBOLS,100);
	PLAYERCOMB = 0;
	NPCCOMB = 0;
	ONECOUNT = 0;
	TWOCOUNT = 0;
	THREECOUNT = 0;
	FOURCOUNT = 0;
	FIVECOUNT = 0;
	SIXCOUNT = 0;
	NPCONECOUNT = 0;
	NPCTWOCOUNT = 0;
	NPCTHREECOUNT = 0;
	NPCFOURCOUNT = 0;
	NPCFIVECOUNT = 0;
	NPCSIXCOUNT = 0;
	GUARDPLAYRESULT = GUARDWONMONEY - GUARDLOSTMONEY;
	POCKERENEMY = Hlp_GetNpc(hero);
    blockMainMenu(0); // W³¹czam mo¿liwoœæ korzystania z menu g³ównego gry.
};

func void npcdorethrow()
{
	if(NPCBONE1RETHROW == TRUE)
	{
		if(NPCBONE1 == 1)
		{
			NPCONECOUNT -= 1;
		};
		if(NPCBONE1 == 2)
		{
			NPCTWOCOUNT -= 1;
		};
		if(NPCBONE1 == 3)
		{
			NPCTHREECOUNT -= 1;
		};
		if(NPCBONE1 == 4)
		{
			NPCFOURCOUNT -= 1;
		};
		if(NPCBONE1 == 5)
		{
			NPCFIVECOUNT -= 1;
		};
		if(NPCBONE1 == 6)
		{
			NPCSIXCOUNT -= 1;
		};
		throw1bone();
	};
	if(NPCBONE2RETHROW == TRUE)
	{
		if(NPCBONE2 == 1)
		{
			NPCONECOUNT -= 1;
		};
		if(NPCBONE2 == 2)
		{
			NPCTWOCOUNT -= 1;
		};
		if(NPCBONE2 == 3)
		{
			NPCTHREECOUNT -= 1;
		};
		if(NPCBONE2 == 4)
		{
			NPCFOURCOUNT -= 1;
		};
		if(NPCBONE2 == 5)
		{
			NPCFIVECOUNT -= 1;
		};
		if(NPCBONE2 == 6)
		{
			NPCSIXCOUNT -= 1;
		};
		throw2bone();
	};
	if(NPCBONE3RETHROW == TRUE)
	{
		if(NPCBONE3 == 1)
		{
			NPCONECOUNT -= 1;
		};
		if(NPCBONE3 == 2)
		{
			NPCTWOCOUNT -= 1;
		};
		if(NPCBONE3 == 3)
		{
			NPCTHREECOUNT -= 1;
		};
		if(NPCBONE3 == 4)
		{
			NPCFOURCOUNT -= 1;
		};
		if(NPCBONE3 == 5)
		{
			NPCFIVECOUNT -= 1;
		};
		if(NPCBONE3 == 6)
		{
			NPCSIXCOUNT -= 1;
		};
		throw3bone();
	};
	if(NPCBONE4RETHROW == TRUE)
	{
		if(NPCBONE4 == 1)
		{
			NPCONECOUNT -= 1;
		};
		if(NPCBONE4 == 2)
		{
			NPCTWOCOUNT -= 1;
		};
		if(NPCBONE4 == 3)
		{
			NPCTHREECOUNT -= 1;
		};
		if(NPCBONE4 == 4)
		{
			NPCFOURCOUNT -= 1;
		};
		if(NPCBONE4 == 5)
		{
			NPCFIVECOUNT -= 1;
		};
		if(NPCBONE4 == 6)
		{
			NPCSIXCOUNT -= 1;
		};
		throw4bone();
	};
	if(NPCBONE5RETHROW == TRUE)
	{
		if(NPCBONE5 == 1)
		{
			NPCONECOUNT -= 1;
		};
		if(NPCBONE5 == 2)
		{
			NPCTWOCOUNT -= 1;
		};
		if(NPCBONE5 == 3)
		{
			NPCTHREECOUNT -= 1;
		};
		if(NPCBONE5 == 4)
		{
			NPCFOURCOUNT -= 1;
		};
		if(NPCBONE5 == 5)
		{
			NPCFIVECOUNT -= 1;
		};
		if(NPCBONE5 == 6)
		{
			NPCSIXCOUNT -= 1;
		};
		throw5bone();
	};
};

func void playerwon()
{
	GAMERESULT = -1;
    PlayerGames_Won_Counter += 1;
    GUARDWONMONEY += STAVKA;
    
    // Hazardzista traci pieni¹dze
    Poker_Gambler_UpdatePocket(-STAVKA);
    
    // ACHIEVEMENTS (dajê else-if, by gracz nie dosta³ dwóch osi¹gniêæ jednoczeœnie - bo siê napisy na³o¿¹)
    if (100 == PlayerGames_Won_Counter) { // 100 wygranych gier.
        Achievement_RequestHandle(ACHIEVEMENT_POKER_100GAMESWON);
    } else if (1000 <= GUARDWONMONEY) { // Co najmniej 1000 wygranego z³ota. 
        Achievement_RequestHandle(ACHIEVEMENT_POKER_1000GOLDWON);
    };
	Snd_Play("Geldbeutel");
	Print(POKER_MES_WIN);
	if(STAVKA != -1)
	{
		CreateInvItems(hero,ItMi_Gold,STAVKA * 2);
	};
	endpocker();
};

func void playerlost()
{
	GAMERESULT = 1;
    PlayerGames_Failure_Counter += 1;
    GUARDLOSTMONEY += STAVKA;
    
    // Hazardzista zyskuje pieni¹dze
    Poker_Gambler_UpdatePocket(STAVKA);
    
    // ACHIEVEMENTS (dajê else-if, by gracz nie dosta³ dwóch osi¹gniêæ jednoczeœnie - bo siê napisy na³o¿¹)
    if (100 == PlayerGames_Failure_Counter) { // 100 przegranych gier.
        Achievement_RequestHandle(ACHIEVEMENT_POKER_100GAMESLOST);
    } else if (1000 <= GUARDLOSTMONEY) { // Co najmniej 1000 przegranego z³ota.
        Achievement_RequestHandle(ACHIEVEMENT_POKER_1000GOLDLOST);
    };
    Print(POKER_MES_LOSS);
	endpocker();
};

func void playerequial()
{
	Print(POKER_MES_TIE);
	if(STAVKA != -1)
	{
		CreateInvItems(hero,ItMi_Gold,STAVKA);
	};
	STARTPOCKERMATCH = 2;
};

func void b_pockerdialog_s1()
{
	AI_StopProcessInfos(self);
	hero.aivar[AIV_INVINCIBLE] = TRUE;
	PLAYER_MOBSI_PRODUCTION = MOBSI_POCKER;
	ISINDIALOG = 1;
	AI_ProcessInfos(hero);
};


instance PC_PLAYPOCKER_END(C_Info)
{
	npc = PC_Hero;
	nr = 998;
	condition = pc_playpocker_end_condition;
	information = pc_playpocker_end_info;
	permanent = TRUE;
	description = "(Poddajê siê)";
};


func int pc_playpocker_end_condition()
{
	if((PLAYER_MOBSI_PRODUCTION == MOBSI_POCKER) && (STARTPOCKERMATCH == 3) && (MADESTAVKA == FALSE))
	{
		return TRUE;
	};
};

func void pc_playpocker_end_info()
{
	playerlost();
};


instance PC_PLAYPOCKER_STOP(C_Info)
{
	npc = PC_Hero;
	nr = 999;
	condition = pc_playpocker_stop_condition;
	information = pc_playpocker_stop_info;
	permanent = TRUE;
	description = "(Koniec gry)";
};


func int pc_playpocker_stop_condition()
{
	if((PLAYER_MOBSI_PRODUCTION == MOBSI_POCKER) && (STARTPOCKERMATCH == 2) && (CANMADESTAVKA == FALSE) )
	{
		return TRUE;
	};
};

func void pc_playpocker_stop_info()
{
    if (0 == GAMERESULT) && (1 == MADESTAVKA) {
        PrintScreen(POKER_INTERRUPTEDGAME, -1, YPOS_LEVELUP, Font_Screen, 3);
        
        // Hazardzista zyskuje pieni¹dze
        Poker_Gambler_UpdatePocket(STAVKA);
    };
	endpocker();
};


instance PC_PLAYPOCKER_BACK(C_Info)
{
	npc = PC_Hero;
	nr = 999;
	condition = pc_playpocker_back_condition;
	information = pc_playpocker_back_info;
	permanent = TRUE;
	description = "(Powrót)";
};


func int pc_playpocker_back_condition()
{
	if(((PLAYER_MOBSI_PRODUCTION == MOBSI_POCKER) && (STARTPOCKERMATCH == 2) && (CANMADESTAVKA == TRUE)) || ((PLAYER_MOBSI_PRODUCTION == MOBSI_POCKER) && (CANRETHROW == TRUE)) || ((PLAYER_MOBSI_PRODUCTION == MOBSI_POCKER) && (ADDSTAVKA == TRUE)))
	{
		return TRUE;
	};
};

func void pc_playpocker_back_info()
{
	if(CANMADESTAVKA == TRUE)
	{
		CANMADESTAVKA = FALSE;
	};
	if(CANRETHROW == TRUE)
	{
		CANRETHROW = FALSE;
		RETHROWFIRSTBONE = FALSE;
		RETHROWSECONDBONE = FALSE;
		RETHROWTHIRDBONE = FALSE;
		RETHROWFOURBONE = FALSE;
		RETHROWFIVEBONE = FALSE;
	};
	if(ADDSTAVKA == TRUE)
	{
		ADDSTAVKA = FALSE;
	};
};


instance PC_PLAYPOCKER_MAKESTAVKA(C_Info)
{
	npc = PC_Hero;
	nr = 1;
	condition = pc_playpocker_makestavka_condition;
	information = pc_playpocker_makestavka_info;
	permanent = TRUE;
	description = "(Obstawiam)";
};


func int pc_playpocker_makestavka_condition()
{
	if((PLAYER_MOBSI_PRODUCTION == MOBSI_POCKER) && (STARTPOCKERMATCH == 2) && (CANMADESTAVKA == FALSE) && (STAVKA <= 4) && (STAVKA != -1))
	{
		return TRUE;
	};
};

func void pc_playpocker_makestavka_info()
{
	CANMADESTAVKA = TRUE;
};


instance PC_PLAYPOCKER_LOWSTAVKA_1(C_Info)
{
	npc = PC_Hero;
	nr = 3;
	condition = pc_playpocker_lowstavka_1_condition;
	information = pc_playpocker_lowstavka_info;
	permanent = TRUE;
	description = POKER_BET_GOLD_5;
};


func int pc_playpocker_lowstavka_1_condition()
{
	if((PLAYER_MOBSI_PRODUCTION == MOBSI_POCKER) && (STARTPOCKERMATCH == 2) && (CANMADESTAVKA == TRUE) && (STAVKA == 1))
	{
		return TRUE;
	};
};


instance PC_PLAYPOCKER_LOWSTAVKA_2(C_Info)
{
	npc = PC_Hero;
	nr = 3;
	condition = pc_playpocker_lowstavka_2_condition;
	information = pc_playpocker_lowstavka_info;
	permanent = TRUE;
	description = POKER_BET_GOLD_35;
};


func int pc_playpocker_lowstavka_2_condition()
{
	if((PLAYER_MOBSI_PRODUCTION == MOBSI_POCKER) && (STARTPOCKERMATCH == 2) && (CANMADESTAVKA == TRUE) && (STAVKA == 2))
	{
		return TRUE;
	};
};


instance PC_PLAYPOCKER_LOWSTAVKA_3(C_Info)
{
	npc = PC_Hero;
	nr = 3;
	condition = pc_playpocker_lowstavka_3_condition;
	information = pc_playpocker_lowstavka_info;
	permanent = TRUE;
	description = POKER_BET_GOLD_65;
};


func int pc_playpocker_lowstavka_3_condition()
{
	if((PLAYER_MOBSI_PRODUCTION == MOBSI_POCKER) && (STARTPOCKERMATCH == 2) && (CANMADESTAVKA == TRUE) && (STAVKA == 3))
	{
		return TRUE;
	};
};


instance PC_PLAYPOCKER_LOWSTAVKA_4(C_Info)
{
	npc = PC_Hero;
	nr = 3;
	condition = pc_playpocker_lowstavka_4_condition;
	information = pc_playpocker_lowstavka_info;
	permanent = TRUE;
	description = POKER_BET_GOLD_95;
};


func int pc_playpocker_lowstavka_4_condition()
{
	if((PLAYER_MOBSI_PRODUCTION == MOBSI_POCKER) && (STARTPOCKERMATCH == 2) && (CANMADESTAVKA == TRUE) && (STAVKA == 4))
	{
		return TRUE;
	};
};


instance PC_PLAYPOCKER_MIDSTAVKA_1(C_Info)
{
	npc = PC_Hero;
	nr = 4;
	condition = pc_playpocker_midstavka_1_condition;
	information = pc_playpocker_midstavka_info;
	permanent = TRUE;
	description = POKER_BET_GOLD_15;
};


func int pc_playpocker_midstavka_1_condition()
{
	if((PLAYER_MOBSI_PRODUCTION == MOBSI_POCKER) && (STARTPOCKERMATCH == 2) && (CANMADESTAVKA == TRUE) && (STAVKA == 1))
	{
		return TRUE;
	};
};


instance PC_PLAYPOCKER_MIDSTAVKA_2(C_Info)
{
	npc = PC_Hero;
	nr = 4;
	condition = pc_playpocker_midstavka_2_condition;
	information = pc_playpocker_midstavka_info;
	permanent = TRUE;
	description = POKER_BET_GOLD_45;
};


func int pc_playpocker_midstavka_2_condition()
{
	if((PLAYER_MOBSI_PRODUCTION == MOBSI_POCKER) && (STARTPOCKERMATCH == 2) && (CANMADESTAVKA == TRUE) && (STAVKA == 2))
	{
		return TRUE;
	};
};


instance PC_PLAYPOCKER_MIDSTAVKA_3(C_Info)
{
	npc = PC_Hero;
	nr = 4;
	condition = pc_playpocker_midstavka_3_condition;
	information = pc_playpocker_midstavka_info;
	permanent = TRUE;
	description = POKER_BET_GOLD_75;
};


func int pc_playpocker_midstavka_3_condition()
{
	if((PLAYER_MOBSI_PRODUCTION == MOBSI_POCKER) && (STARTPOCKERMATCH == 2) && (CANMADESTAVKA == TRUE) && (STAVKA == 3))
	{
		return TRUE;
	};
};


instance PC_PLAYPOCKER_MIDSTAVKA_4(C_Info)
{
	npc = PC_Hero;
	nr = 4;
	condition = pc_playpocker_midstavka_4_condition;
	information = pc_playpocker_midstavka_info;
	permanent = TRUE;
	description = POKER_BET_GOLD_105;
};


func int pc_playpocker_midstavka_4_condition()
{
	if((PLAYER_MOBSI_PRODUCTION == MOBSI_POCKER) && (STARTPOCKERMATCH == 2) && (CANMADESTAVKA == TRUE) && (STAVKA == 4))
	{
		return TRUE;
	};
};


instance PC_PLAYPOCKER_HIGHSTAVKA_1(C_Info)
{
	npc = PC_Hero;
	nr = 5;
	condition = pc_playpocker_highstavka_1_condition;
	information = pc_playpocker_highstavka_info;
	permanent = TRUE;
	description = POKER_BET_GOLD_25;
};


func int pc_playpocker_highstavka_1_condition()
{
	if((PLAYER_MOBSI_PRODUCTION == MOBSI_POCKER) && (STARTPOCKERMATCH == 2) && (CANMADESTAVKA == TRUE) && (STAVKA == 1))
	{
		return TRUE;
	};
};


instance PC_PLAYPOCKER_HIGHSTAVKA_2(C_Info)
{
	npc = PC_Hero;
	nr = 5;
	condition = pc_playpocker_highstavka_2_condition;
	information = pc_playpocker_highstavka_info;
	permanent = TRUE;
	description = POKER_BET_GOLD_55;
};


func int pc_playpocker_highstavka_2_condition()
{
	if((PLAYER_MOBSI_PRODUCTION == MOBSI_POCKER) && (STARTPOCKERMATCH == 2) && (CANMADESTAVKA == TRUE) && (STAVKA == 2))
	{
		return TRUE;
	};
};


instance PC_PLAYPOCKER_HIGHSTAVKA_3(C_Info)
{
	npc = PC_Hero;
	nr = 5;
	condition = pc_playpocker_highstavka_3_condition;
	information = pc_playpocker_highstavka_info;
	permanent = TRUE;
	description = POKER_BET_GOLD_85;
};


func int pc_playpocker_highstavka_3_condition()
{
	if((PLAYER_MOBSI_PRODUCTION == MOBSI_POCKER) && (STARTPOCKERMATCH == 2) && (CANMADESTAVKA == TRUE) && (STAVKA == 3))
	{
		return TRUE;
	};
};


instance PC_PLAYPOCKER_HIGHSTAVKA_4(C_Info)
{
	npc = PC_Hero;
	nr = 5;
	condition = pc_playpocker_highstavka_4_condition;
	information = pc_playpocker_highstavka_info;
	permanent = TRUE;
	description = POKER_BET_GOLD_115;
};


func int pc_playpocker_highstavka_4_condition()
{
	if((PLAYER_MOBSI_PRODUCTION == MOBSI_POCKER) && (STARTPOCKERMATCH == 2) && (CANMADESTAVKA == TRUE) && (STAVKA == 4))
	{
		return TRUE;
	};
};

func void pc_playpocker_lowstavka_info()
{
	if(STAVKA == 1)
	{
		if(Npc_HasItems(other,ItMi_Gold) >= 5)
		{
			STAVKA = 5;
		};
	}
	else if(STAVKA == 2)
	{
		if(Npc_HasItems(other,ItMi_Gold) >= 35)
		{
			STAVKA = 35;
		};
	}
	else if(STAVKA == 3)
	{
		if(Npc_HasItems(other,ItMi_Gold) >= 65)
		{
			STAVKA = 65;
		};
	}
	else if(STAVKA == 4)
	{
		if(Npc_HasItems(other,ItMi_Gold) >= 95)
		{
			STAVKA = 95;
		};
	};
	if(STAVKA > 4)
	{
		Npc_RemoveInvItems(hero,ItMi_Gold,STAVKA);
		CANMADESTAVKA = FALSE;
		MADESTAVKA = TRUE;
	}
	else
	{
		Print(NOTENOUGHGOLD);
	};
};

func void pc_playpocker_midstavka_info()
{
	if(STAVKA == 1)
	{
		if(Npc_HasItems(other,ItMi_Gold) >= 15)
		{
			STAVKA = 15;
		};
	}
	else if(STAVKA == 2)
	{
		if(Npc_HasItems(other,ItMi_Gold) >= 45)
		{
			STAVKA = 45;
		};
	}
	else if(STAVKA == 3)
	{
		if(Npc_HasItems(other,ItMi_Gold) >= 75)
		{
			STAVKA = 75;
		};
	}
	else if(STAVKA == 4)
	{
		if(Npc_HasItems(other,ItMi_Gold) >= 105)
		{
			STAVKA = 105;
		};
	};
	if(STAVKA > 4)
	{
		Npc_RemoveInvItems(hero,ItMi_Gold,STAVKA);
		CANMADESTAVKA = FALSE;
		MADESTAVKA = TRUE;
	}
	else
	{
		Print(NOTENOUGHGOLD);
	};
};

func void pc_playpocker_highstavka_info()
{
	if(STAVKA == 1)
	{
		if(Npc_HasItems(other,ItMi_Gold) >= 25)
		{
			STAVKA = 25;
		};
	}
	else if(STAVKA == 2)
	{
		if(Npc_HasItems(other,ItMi_Gold) >= 55)
		{
			STAVKA = 55;
		};
	}
	else if(STAVKA == 3)
	{
		if(Npc_HasItems(other,ItMi_Gold) >= 85)
		{
			STAVKA = 85;
		};
	}
	else if(STAVKA == 4)
	{
		if(Npc_HasItems(other,ItMi_Gold) >= 115)
		{
			STAVKA = 115;
		};
	};
	if(STAVKA > 4)
	{
		Npc_RemoveInvItems(hero,ItMi_Gold,STAVKA);
		CANMADESTAVKA = FALSE;
		MADESTAVKA = TRUE;
	}
	else
	{
		Print(NOTENOUGHGOLD);
	};
};


instance PC_PLAYPOCKER_THROWBONES(C_Info)
{
	npc = PC_Hero;
	nr = 1;
	condition = pc_playpocker_throwbones_condition;
	information = pc_playpocker_throwbones_info;
	permanent = TRUE;
	description = "(Rzuæ koœæmi)";
};


func int pc_playpocker_throwbones_condition()
{
	if(((PLAYER_MOBSI_PRODUCTION == MOBSI_POCKER) && (STARTPOCKERMATCH == 2) && (MADESTAVKA == TRUE)) || ((PLAYER_MOBSI_PRODUCTION == MOBSI_POCKER) && (STARTPOCKERMATCH == 2) && (STAVKA == -1)))
	{
		return TRUE;
	};
};

func void pc_playpocker_throwbones_info()
{
	ONECOUNT = 0;
	TWOCOUNT = 0;
	THREECOUNT = 0;
	FOURCOUNT = 0;
	FIVECOUNT = 0;
	SIXCOUNT = 0;
	NPCONECOUNT = 0;
	NPCTWOCOUNT = 0;
	NPCTHREECOUNT = 0;
	NPCFOURCOUNT = 0;
	NPCFIVECOUNT = 0;
	NPCSIXCOUNT = 0;
	PLAYERTURN = TRUE;
	throwbones();
	PLAYERTURN = FALSE;
	throwbones();
	STARTPOCKERMATCH = 3;
};


instance PC_PLAYPOCKER_CONTINUE(C_Info)
{
	npc = PC_Hero;
	nr = 2;
	condition = pc_playpocker_continue_condition;
	information = pc_playpocker_continue_info;
	permanent = TRUE;
	description = "(Kontynuuj grê)";
};


func int pc_playpocker_continue_condition()
{
	if((PLAYER_MOBSI_PRODUCTION == MOBSI_POCKER) && (STARTPOCKERMATCH == 3) && (CANRETHROW == FALSE) && (ADDSTAVKA == FALSE))
	{
		return TRUE;
	};
};

func void pc_playpocker_continue_info()
{
	npcrethrow();
	npcdorethrow();
	countcombination();
	STARTPOCKERMATCH = 4;
};


instance PC_PLAYPOCKER_ADDSTAVKA(C_Info)
{
	npc = PC_Hero;
	nr = 1;
	condition = pc_playpocker_addstavka_condition;
	information = pc_playpocker_addstavka_info;
	permanent = TRUE;
	description = "(Podnieœ stawkê)";
};


func int pc_playpocker_addstavka_condition()
{
	if(
        (PLAYER_MOBSI_PRODUCTION == MOBSI_POCKER) &&
        (STARTPOCKERMATCH == 3) &&
        (CANRETHROW == FALSE) &&
        (ADDSTAVKA == FALSE) &&
        (STAVKA != 25) &&
        (STAVKA != 55) &&
        (STAVKA != 85) &&
        (STAVKA != 115) &&
        (MADEADDSTAVKA == FALSE) &&
        (STAVKA != -1)) &&
        (10 <= Npc_HasItems(hero, ItMi_Gold))
	{
		return TRUE;
	};
};

func void pc_playpocker_addstavka_info()
{
	ADDSTAVKA = TRUE;
};


instance PC_PLAYPOCKER_ADDSTAVKA10(C_Info)
{
	npc = PC_Hero;
	nr = 1;
	condition = pc_playpocker_addstavka10_condition;
	information = pc_playpocker_addstavka10_info;
	permanent = TRUE;
	description = "(Podnieœ o 10 sztuk z³ota)";
};


func int pc_playpocker_addstavka10_condition()
{
	if (
        (PLAYER_MOBSI_PRODUCTION == MOBSI_POCKER) &&
        (STARTPOCKERMATCH == 3) &&
        (CANRETHROW == FALSE) &&
        (ADDSTAVKA == TRUE) &&
        (MADEADDSTAVKA == FALSE) &&
        (10 <= Npc_HasItems(hero, ItMi_Gold))
    )
	{
		return TRUE;
	};
};

func void pc_playpocker_addstavka10_info()
{
	STAVKA += 10;
	Npc_RemoveInvItems(hero,ItMi_Gold,10);
	ADDSTAVKA = FALSE;
	MADEADDSTAVKA = TRUE;
};


instance PC_PLAYPOCKER_ADDSTAVKA20(C_Info)
{
	npc = PC_Hero;
	nr = 1;
	condition = pc_playpocker_addstavka20_condition;
	information = pc_playpocker_addstavka20_info;
	permanent = TRUE;
	description = "(Podnieœ o 20 sztuk z³ota)";
};


func int pc_playpocker_addstavka20_condition()
{
	if(
        (PLAYER_MOBSI_PRODUCTION == MOBSI_POCKER) &&
        (STARTPOCKERMATCH == 3) &&
        (CANRETHROW == FALSE) &&
        (ADDSTAVKA == TRUE) &&
        (STAVKA != 15) &&
        (STAVKA != 45) &&
        (STAVKA != 75) &&
        (STAVKA != 115) &&
        (MADEADDSTAVKA == FALSE) &&
        (20 <= Npc_HasItems(hero, ItMi_Gold))
    )
	{
		return TRUE;
	};
};

func void pc_playpocker_addstavka20_info()
{
	STAVKA += 20;
	Npc_RemoveInvItems(hero,ItMi_Gold,20);
	ADDSTAVKA = FALSE;
	MADEADDSTAVKA = TRUE;
};


instance PC_PLAYPOCKER_RETHROWBONES(C_Info)
{
	npc = PC_Hero;
	nr = 1;
	condition = pc_playpocker_rethrowbones_condition;
	information = pc_playpocker_rethrowbones_info;
	permanent = TRUE;
	description = "(Wybierz koœci do przerzucenia)";//"(Pomieszaæ koœci)";
};


func int pc_playpocker_rethrowbones_condition()
{
	if((PLAYER_MOBSI_PRODUCTION == MOBSI_POCKER) && (STARTPOCKERMATCH == 3) && (CANRETHROW == FALSE) && (ADDSTAVKA == FALSE))
	{
		return TRUE;
	};
};

func void pc_playpocker_rethrowbones_info()
{
	RETHROWFIRSTBONE = FALSE;
	RETHROWSECONDBONE = FALSE;
	RETHROWTHIRDBONE = FALSE;
	RETHROWFOURBONE = FALSE;
	RETHROWFIVEBONE = FALSE;
	CANRETHROW = TRUE;
};


instance PC_PLAYPOCKER_RETHROWBONES_FIRST(C_Info)
{
	npc = PC_Hero;
	nr = 1;
	condition = pc_playpocker_rethrowbones_first_condition;
	information = pc_playpocker_rethrowbones_first_info;
	permanent = TRUE;
	description = "(Wybierz pierwsz¹ koœæ)";
};
func int pc_playpocker_rethrowbones_first_condition()
{
	if(
        (PLAYER_MOBSI_PRODUCTION == MOBSI_POCKER)
        && (CANRETHROW == TRUE)
        && (RETHROWFIRSTBONE == FALSE)
    )
	{
		return TRUE;
	};
};
instance PC_PLAYPOCKER_RETHROWBONESREVERSE_FIRST(C_Info)
{
	npc = PC_Hero;
	nr = 1;
	condition = pc_playpocker_rethrowbonesREVERSE_first_condition;
	information = pc_playpocker_rethrowbones_first_info;
	permanent = TRUE;
	description = "(Odznacz pierwsz¹ koœæ)";
};
func int pc_playpocker_rethrowbonesREVERSE_first_condition()
{
	if(
        (PLAYER_MOBSI_PRODUCTION == MOBSI_POCKER)
        && (CANRETHROW == TRUE)
        && (RETHROWFIRSTBONE == TRUE)
    )
	{
		return TRUE;
	};
};

func void pc_playpocker_rethrowbones_first_info()
{
	if (0 == RETHROWFIRSTBONE) {
        RETHROWFIRSTBONE = 1;
    } else {
        RETHROWFIRSTBONE = 0;
    };
};


instance PC_PLAYPOCKER_RETHROWBONES_SECOND(C_Info)
{
	npc = PC_Hero;
	nr = 2;
	condition = pc_playpocker_rethrowbones_second_condition;
	information = pc_playpocker_rethrowbones_second_info;
	permanent = TRUE;
	description = "(Wybierz drug¹ koœæ)";
};
func int pc_playpocker_rethrowbones_second_condition()
{
	if((PLAYER_MOBSI_PRODUCTION == MOBSI_POCKER) && (CANRETHROW == TRUE) && (RETHROWSECONDBONE == FALSE))
	{
		return TRUE;
	};
};
instance PC_PLAYPOCKER_RETHROWBONESREVERSE_SECOND(C_Info)
{
	npc = PC_Hero;
	nr = 2;
	condition = pc_playpocker_rethrowbonesREVERSE_second_condition;
	information = pc_playpocker_rethrowbones_second_info;
	permanent = TRUE;
	description = "(Odznacz drug¹ koœæ)";
};
func int pc_playpocker_rethrowbonesREVERSE_second_condition()
{
	if((PLAYER_MOBSI_PRODUCTION == MOBSI_POCKER) && (CANRETHROW == TRUE) && (RETHROWSECONDBONE == TRUE))
	{
		return TRUE;
	};
};

func void pc_playpocker_rethrowbones_second_info()
{
	if (0 == RETHROWSECONDBONE) {
        RETHROWSECONDBONE = 1;
    } else {
        RETHROWSECONDBONE = 0;
    };
};


instance PC_PLAYPOCKER_RETHROWBONES_THIRD(C_Info)
{
	npc = PC_Hero;
	nr = 3;
	condition = pc_playpocker_rethrowbones_third_condition;
	information = pc_playpocker_rethrowbones_third_info;
	permanent = TRUE;
	description = "(Wybierz trzeci¹ koœæ)";
};
func int pc_playpocker_rethrowbones_third_condition()
{
	if((PLAYER_MOBSI_PRODUCTION == MOBSI_POCKER) && (CANRETHROW == TRUE) && (RETHROWTHIRDBONE == FALSE))
	{
		return TRUE;
	};
};
instance PC_PLAYPOCKER_RETHROWBONESREVERSE_THIRD(C_Info)
{
	npc = PC_Hero;
	nr = 3;
	condition = pc_playpocker_rethrowbonesREVERSE_third_condition;
	information = pc_playpocker_rethrowbones_third_info;
	permanent = TRUE;
	description = "(Odznacz trzeci¹ koœæ)";
};
func int pc_playpocker_rethrowbonesREVERSE_third_condition()
{
	if((PLAYER_MOBSI_PRODUCTION == MOBSI_POCKER) && (CANRETHROW == TRUE) && (RETHROWTHIRDBONE == TRUE))
	{
		return TRUE;
	};
};

func void pc_playpocker_rethrowbones_third_info()
{
    if (0 == RETHROWTHIRDBONE) {
        RETHROWTHIRDBONE = 1;
    } else {
        RETHROWTHIRDBONE = 0;
    };
};


instance PC_PLAYPOCKER_RETHROWBONES_FOUR(C_Info)
{
	npc = PC_Hero;
	nr = 4;
	condition = pc_playpocker_rethrowbones_four_condition;
	information = pc_playpocker_rethrowbones_four_info;
	permanent = TRUE;
	description = "(Wybierz czwart¹ koœæ)";
};
func int pc_playpocker_rethrowbones_four_condition()
{
	if((PLAYER_MOBSI_PRODUCTION == MOBSI_POCKER) && (CANRETHROW == TRUE) && (RETHROWFOURBONE == FALSE))
	{
		return TRUE;
	};
};
instance PC_PLAYPOCKER_RETHROWBONESREVERSE_FOUR(C_Info)
{
	npc = PC_Hero;
	nr = 4;
	condition = pc_playpocker_rethrowbonesREVERSE_four_condition;
	information = pc_playpocker_rethrowbones_four_info;
	permanent = TRUE;
	description = "(Odznacz czwart¹ koœæ)";
};
func int pc_playpocker_rethrowbonesREVERSE_four_condition()
{
	if((PLAYER_MOBSI_PRODUCTION == MOBSI_POCKER) && (CANRETHROW == TRUE) && (RETHROWFOURBONE == TRUE))
	{
		return TRUE;
	};
};

func void pc_playpocker_rethrowbones_four_info()
{
	if (0 == RETHROWFOURBONE) {
        RETHROWFOURBONE = 1;
    } else {
        RETHROWFOURBONE = 0;
    };
};


instance PC_PLAYPOCKER_RETHROWBONES_FIVE(C_Info)
{
	npc = PC_Hero;
	nr = 5;
	condition = pc_playpocker_rethrowbones_five_condition;
	information = pc_playpocker_rethrowbones_five_info;
	permanent = TRUE;
	description = "(Wybierz pi¹t¹ koœæ)";
};
func int pc_playpocker_rethrowbones_five_condition()
{
	if((PLAYER_MOBSI_PRODUCTION == MOBSI_POCKER) && (CANRETHROW == TRUE) && (RETHROWFIVEBONE == FALSE))
	{
		return TRUE;
	};
};
instance PC_PLAYPOCKER_RETHROWBONESREVERSE_FIVE(C_Info)
{
	npc = PC_Hero;
	nr = 5;
	condition = pc_playpocker_rethrowbonesREVERSE_five_condition;
	information = pc_playpocker_rethrowbones_five_info;
	permanent = TRUE;
	description = "(Odznacz pi¹t¹ koœæ)";
};
func int pc_playpocker_rethrowbonesREVERSE_five_condition()
{
	if((PLAYER_MOBSI_PRODUCTION == MOBSI_POCKER) && (CANRETHROW == TRUE) && (RETHROWFIVEBONE == TRUE))
	{
		return TRUE;
	};
};

func void pc_playpocker_rethrowbones_five_info()
{
	if (0 == RETHROWFIVEBONE) {
        RETHROWFIVEBONE = 1;
    } else {
        RETHROWFIVEBONE = 0;
    };
};


instance PC_PLAYPOCKER_RETHROWBONES_DORETHROW(C_Info)
{
	npc = PC_Hero;
	nr = 6;
	condition = pc_playpocker_rethrowbones_dorethrow_condition;
	information = pc_playpocker_rethrowbones_dorethrow_info;
	permanent = TRUE;
	description = "(PotwierdŸ powtórny rzut)";
};


func int pc_playpocker_rethrowbones_dorethrow_condition()
{
	if((PLAYER_MOBSI_PRODUCTION == MOBSI_POCKER) && (CANRETHROW == TRUE))
	{
		return TRUE;
	};
};

func void pc_playpocker_rethrowbones_dorethrow_info()
{
	PLAYERTURN = TRUE;
	if(RETHROWFIRSTBONE == TRUE)
	{
		if(PLAYERBONE1 == 1)
		{
			ONECOUNT -= 1;
		};
		if(PLAYERBONE1 == 2)
		{
			TWOCOUNT -= 1;
		};
		if(PLAYERBONE1 == 3)
		{
			THREECOUNT -= 1;
		};
		if(PLAYERBONE1 == 4)
		{
			FOURCOUNT -= 1;
		};
		if(PLAYERBONE1 == 5)
		{
			FIVECOUNT -= 1;
		};
		if(PLAYERBONE1 == 6)
		{
			SIXCOUNT -= 1;
		};
		throw1bone();
	};
	if(RETHROWSECONDBONE == TRUE)
	{
		if(PLAYERBONE2 == 1)
		{
			ONECOUNT -= 1;
		};
		if(PLAYERBONE2 == 2)
		{
			TWOCOUNT -= 1;
		};
		if(PLAYERBONE2 == 3)
		{
			THREECOUNT -= 1;
		};
		if(PLAYERBONE2 == 4)
		{
			FOURCOUNT -= 1;
		};
		if(PLAYERBONE2 == 5)
		{
			FIVECOUNT -= 1;
		};
		if(PLAYERBONE2 == 6)
		{
			SIXCOUNT -= 1;
		};
		throw2bone();
	};
	if(RETHROWTHIRDBONE == TRUE)
	{
		if(PLAYERBONE3 == 1)
		{
			ONECOUNT -= 1;
		};
		if(PLAYERBONE3 == 2)
		{
			TWOCOUNT -= 1;
		};
		if(PLAYERBONE3 == 3)
		{
			THREECOUNT -= 1;
		};
		if(PLAYERBONE3 == 4)
		{
			FOURCOUNT -= 1;
		};
		if(PLAYERBONE3 == 5)
		{
			FIVECOUNT -= 1;
		};
		if(PLAYERBONE3 == 6)
		{
			SIXCOUNT -= 1;
		};
		throw3bone();
	};
	if(RETHROWFOURBONE == TRUE)
	{
		if(PLAYERBONE4 == 1)
		{
			ONECOUNT -= 1;
		};
		if(PLAYERBONE4 == 2)
		{
			TWOCOUNT -= 1;
		};
		if(PLAYERBONE4 == 3)
		{
			THREECOUNT -= 1;
		};
		if(PLAYERBONE4 == 4)
		{
			FOURCOUNT -= 1;
		};
		if(PLAYERBONE4 == 5)
		{
			FIVECOUNT -= 1;
		};
		if(PLAYERBONE4 == 6)
		{
			SIXCOUNT -= 1;
		};
		throw4bone();
	};
	if(RETHROWFIVEBONE == TRUE)
	{
		if(PLAYERBONE5 == 1)
		{
			ONECOUNT -= 1;
		};
		if(PLAYERBONE5 == 2)
		{
			TWOCOUNT -= 1;
		};
		if(PLAYERBONE5 == 3)
		{
			THREECOUNT -= 1;
		};
		if(PLAYERBONE5 == 4)
		{
			FOURCOUNT -= 1;
		};
		if(PLAYERBONE5 == 5)
		{
			FIVECOUNT -= 1;
		};
		if(PLAYERBONE5 == 6)
		{
			SIXCOUNT -= 1;
		};
		throw5bone();
	};
	countcombination();
	CANRETHROW = FALSE;
	PLAYERTURN = FALSE;
	npcrethrow();
	npcdorethrow();
	countcombination();
	STARTPOCKERMATCH = 4;
};


instance PC_PLAYPOCKER_ENDGAME(C_Info)
{
	npc = PC_Hero;
	nr = 1;
	condition = pc_playpocker_endgame_condition;
	information = pc_playpocker_endgame_info;
	permanent = TRUE;
	description = "(Zakoñcz grê)";
};


func int pc_playpocker_endgame_condition()
{
	if((PLAYER_MOBSI_PRODUCTION == MOBSI_POCKER) && (STARTPOCKERMATCH == 4))
	{
		return TRUE;
	};
};

func void pc_playpocker_endgame_info()
{
	if(PLAYERCOMB > NPCCOMB)
	{
		playerwon();
	}
	else if(PLAYERCOMB < NPCCOMB)
	{
		playerlost();
	}
	else
	{
		playerequial();
	};
};

func void playpocker(var int chosenstavka,var C_Npc enemy)
{
	Wld_PlayEffect("POCKERTABLE",hero,hero,0,0,0,FALSE);
	PrintScreen("7",30,71,FONT_SYMBOLS,100);
	PrintScreen("7",39,71,FONT_SYMBOLS,100);
	PrintScreen("7",48,71,FONT_SYMBOLS,100);
	PrintScreen("7",57,71,FONT_SYMBOLS,100);
	PrintScreen("7",66,71,FONT_SYMBOLS,100);
	PrintScreen("7",30,21,FONT_SYMBOLS,100);
	PrintScreen("7",39,21,FONT_SYMBOLS,100);
	PrintScreen("7",48,21,FONT_SYMBOLS,100);
	PrintScreen("7",57,21,FONT_SYMBOLS,100);
	PrintScreen("7",66,21,FONT_SYMBOLS,100);
	STAVKA = chosenstavka;
	POCKERENEMY = Hlp_GetNpc(enemy);
	STARTPOCKERMATCH = 1;
	AI_StopProcessInfos(self);
};


instance DIA_POCKERRESULT(C_Info)
{
	nr = 1;
	condition = dia_pockerresult_condition;
	information = dia_pockerresult_info;
	permanent = TRUE;
	important = TRUE;
};


func int dia_pockerresult_condition()
{
	if (MUSTTELLRESULT == TRUE)
	{
		return TRUE;
	};
};

func void dia_pockerresult_info()
{
	if(Hlp_GetInstanceID(self) == Hlp_GetInstanceID(NONE_7900_HAZARDZISTA))
	{
		if(GAMERESULT == -1)
		{
            AI_Output(self, other ,"DIA_POKER_WIN"); //Gratulujê, dobry z ciebie gracz!
		}
		else if(GAMERESULT == 1)
		{
            AI_Output(self, other ,"DIA_POKER_LOST"); //Ha! Przegra³eœ, nie masz szans z mistrzem koœcianego pokera!
		};
	};
	MUSTTELLRESULT = FALSE;
    GAMERESULT = 0;
};

func void b_assignpocker_aftergame(var C_Npc slf)
{
	dia_pockerresult.npc = Hlp_GetInstanceID(slf);
};

