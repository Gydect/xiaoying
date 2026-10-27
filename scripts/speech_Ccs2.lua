return
{
	ACTIONFAIL =
	{
        REPAIR =
        {
            WRONGPIECE = "你怎么把牛至接在脑袋上了？",		--化石骨架拼接错误
        },
        BUILD =
        {
            MOUNTED = "好像不行哦",		--建造失败（骑乘状态）
            HASPET = "哭哭，人家做不到QAQ",		--建造失败（已经有一个宠物了）
        },
		SHAVE =
		{
			AWAKEBEEFALO = "还是等晚上再来吧",		--给醒着的牛刮毛
			GENERIC = "哭哭，人家又搞砸了QAQ",		--刮牛毛失败
			NOBITS = "等毛长好再来吧",		--给没毛的牛刮毛
		},
		STORE =
		{
			GENERIC = "就不能给人家一个大一点的包包嘛？",		--存放东西失败
			NOTALLOWED = "人家塞不进去了啦~",		--存放东西--不被允许
			INUSE = "让我看看（超大声）",		--别人正在用箱子
            NOTMASTERCHEF = "用不了哎",		--暂无注释
		},
        CONSTRUCT =
        {
            INUSE = "人家想要嘛",		--建筑正在使用
            NOTALLOWED = "要等等，好急急",		--建筑不允许使用
            EMPTY = "被玩坏了嘛？再做个新的吧",		--建筑空了
            MISMATCH = "不是啦",		--升级套件错误（目前用不到）
        },
		RUMMAGE =
		{	
			GENERIC = "我撬棍呢？？",		--打开箱子失败
			INUSE = "可恶，偷我东西！",		--打开箱子 正在使用
            NOTMASTERCHEF = "用不了哎",		--暂无注释
		},
		UNLOCK =
        {
        },
		USEKLAUSSACKKEY =
        {
        	WRONGKEY = "有点好玩！",		--使用克劳斯钥匙
        	KLAUS = "他肚子上为啥有个锁？",		--克劳斯
        },
		ACTIVATE = 
		{
			LOCKED_GATE = "犀牛屁股里掏出来的，也不知道有什么用",		--远古钥匙
		},
        COOK =
        {
            GENERIC = "弄砸了喔",		--做饭失败
            INUSE = "偷偷吃了不会被发现吧",		--做饭失败-别人在用锅
            TOOFAR = "太远了",		--做饭失败-太远
        },
        START_CARRAT_RACE =
        {
            NO_RACERS = "啊，好穷",		--暂无注释
        },
        FISH_OCEAN =
		{
			TOODEEP = "嘬嘬嘬~",		--暂无注释
		},
        OCEAN_FISHING_POND =
		{
			WRONGGEAR = "池塘可能不需要这个",		--暂无注释
		},
        GIVE =
        {
            GENERIC = "你不要我就扔了哦",		--给予失败
            DEAD = "你怎么不要，是不想要嘛？",		--给予 -目标死亡
            SLEEPING = "起床了，大懒猪！",		--给予--目标睡觉
            BUSY = "别动，举起手来！",		--给予--目标正忙
            ABIGAILHEART = "姐姐你怎么不吃",		--给阿比盖尔 救赎之心
            GHOSTHEART = "嘬嘬嘬~",		--给鬼魂 救赎之心
            NOTGEM = "不是啦！",		--给的不是宝石
            WRONGGEM = "不对啦！",		--给错了宝石
            NOTSTAFF = "看我把魔法棒塞进去！",		--给月石祭坛的物品不是法杖
            MUSHROOMFARM_NEEDSSHROOM = "像个棺材!",		--蘑菇农场需要蘑菇
            MUSHROOMFARM_NEEDSLOG = "棺材烂了",		--蘑菇农场需要活木
            SLOTFULL = "已经有了哦",		--已经放了材料后，再给雕像桌子再给一个材料
            FOODFULL = "有东西在烹饪中了",		--没调用
            NOTDISH = "啵！！",		--没调用
            DUPLICATE = "那我可丢掉了喔！",		--给雕像桌子已经学习过的图纸
            NOTSCULPTABLE = "不对哦，要不试试用便便！",		--给陶艺圆盘的东西不对
            NOTATRIUMKEY = "不是这个啦，你是真人吗？",		--中庭钥匙不对
            CANTSHADOWREVIVE = "还没好哦，去摸鱼吧",		--中庭仍在CD
            WRONGSHADOWFORM = "那个看着不对……",		--没调用
            NOMOON = "地下没有月光",		--洞穴里建造月石科技
			PIGKINGGAME_MESSY = "东西太多了",		--猪王旁边有建筑，不能开始抢元宝
			PIGKINGGAME_DANGER = "时机未到！",		--危险，不能开始抢元宝
			PIGKINGGAME_TOOLATE = "已经晚上了哦，猪也要休息的",		--不是白天，不能开始抢元宝
        },
        GIVETOPLAYER =
        {
            FULL = "你不要我就扔了哦",		--给玩家一个东西 -但是背包满了
            DEAD = "你怎么不要，是不想要嘛？",		--给死亡的玩家一个东西
            SLEEPING = "好好睡吧，我看看你小可里有什么好东西！",		--给睡觉的玩家一个东西
            BUSY = "爬过来，女王的赏赐~",		--给忙碌的玩家一个东西
        },
        GIVEALLTOPLAYER =
        {
            FULL = "我说怎么什么都找不到，原来都带在你身上啦",		--给人一组东西 但是背包满了
            DEAD = "啊！有鬼呀",		--给于死去的玩家一组物品
            SLEEPING = "你是猪嘛？能不能别睡了！",		--给于正在睡觉的玩家一组物品
            BUSY = "等等人家嘛！！",		--给于正在忙碌的玩家一组物品
        },
        WRITE =
        {
            GENERIC = "来人帮本小姐写一下",		--写字失败
            INUSE = "你还没完嘛，是不是便秘了！",		--写字 正在使用中
        },
        DRAW =
        {
            NOIMAGE = "我这么好看，不给我画一张嘛？",		--画图缺乏图像
        },
        CHANGEIN =
        {
            GENERIC = "想偷看人家换衣服？不给！",		--换装失败 
            BURNING = "哎呀！燃起来了！",		--换装失败-着火了
            INUSE = "走开啦，你在找什么？",		--衣橱有人占用
        },
        ATTUNE =
        {
            NOHEALTH = "要死了啦！",		--制造肉雕像血量不足
        },
        MOUNT =
        {
            TARGETINCOMBAT = "牛牛好大好威风……",		--骑乘，牛正在战斗
            INUSE = "给我玩玩你的大牛牛！",		--骑乘（牛被占据）
        },
        SADDLE =
        {
            TARGETINCOMBAT = "先戴上再玩嘛，安全第一！",		--给战斗状态的牛上鞍
        },
        TEACH =
        {
            KNOWN = "我这么聪明，还用学？",		--学习已经知道的蓝图
            CANTLEARN = "假的啦，你来你也不行！",		--学习无法学习的蓝图
            WRONGWORLD = "梦里画的地图吗？",		--学习另外一个世界的地图
        },
        WRAPBUNDLE =
        {
            EMPTY = "是新鲜的空气啦",		--打包纸是空的
        },
        PICKUP =
        {
			RESTRICTION = "这是错误 武器",		--熔炉模式下捡起错误的武器
			INUSE = "得等等",		--捡起已经打开的容器
            NOTMINE_YOTC =
            {
                "它不想来",		--暂无注释
                "那个它已经有主人了",		--暂无注释
            },
        },
        SLAUGHTER =
        {
            TOOFAR = "距离太远了！",		--屠杀？？ 因为太远而失败
        },
        REPLATE =
        {
            MISMATCH = "不是正确的菜", 		--暴食-换盘子换错了 比如用碗换碟子
            SAMEDISH = "已经有了！", 		--暴食-换盘子已经换了
        },
        SAIL =
        {
        	REPAIR = "够好了",		--暂无注释
        },
        ROW_FAIL =
        {
            BAD_TIMING0 = "我也会，我也来划！",		--暂无注释
            BAD_TIMING1 = "好累惹……",		--暂无注释
            BAD_TIMING2 = "人家要累死啦！",		--暂无注释
        },
        LOWER_SAIL_FAIL =
        {
            "哎呀！",		--暂无注释
            "下去！",		--暂无注释
            "不行……",		--暂无注释
        },
        BATHBOMB =
        {
            GLASSED = "水太硬",		--暂无注释
            ALREADY_BOMBED = "水够热了",		--暂无注释
        },
		GIVE_TACKLESKETCH =
		{
			DUPLICATE = "算到了！",		--暂无注释
		},
		COMPARE_WEIGHABLE =
		{
			TOO_SMALL = "这鱼有点小！",		--暂无注释
		},
        BEGIN_QUEST =
        {
            ONEGHOST = "这是温蒂的",		--暂无注释
        },
	},
	ACTIONFAIL_GENERIC = "哎呀，不行哎",		--动作失败
	ANNOUNCE_BOAT_LEAK = "人家都被搞湿了！",		--暂无注释
	ANNOUNCE_BOAT_SINK = "急需泳装和救生圈！",		--暂无注释
	ANNOUNCE_DIG_DISEASE_WARNING = "好点了吗？",		--挖起生病的植物
	ANNOUNCE_PICK_DISEASE_WARNING = "病恹恹的",		--（植物生病）
	ANNOUNCE_ADVENTUREFAIL = "搞砸了！",		--没调用（废案）
    ANNOUNCE_MOUNT_LOWHEALTH = "你没事吧，这就不行了吗？",		--牛血量过低
	ANNOUNCE_BEES = "哎呀，被扎到了！",		--戴养蜂帽被蜜蜂蛰
	ANNOUNCE_BOOMERANG = "谁被自己打死人家笑他一年",		--回旋镖
	ANNOUNCE_CHARLIE = "被查理打也是神人了",		--查理即将攻击
	ANNOUNCE_CHARLIE_ATTACK = "真有猪比被查理打啊？",		--被查理攻击
	ANNOUNCE_COLD = "好冷啊，人家想要抱抱！",		--过冷
	ANNOUNCE_HOT = "好热呀，人家想脱衣服！",		--过热
	ANNOUNCE_CRAFTING_FAIL = "不行，还需要更多的材料",		--没调用
	ANNOUNCE_DEERCLOPS = "啊啊啊，是什么东西在叫",		--boss来袭
	ANNOUNCE_CAVEIN = "该死的蚂蚁，看我踩爆你的头！",		--要地震了？？？
	ANNOUNCE_ANTLION_SINKHOLE = 
	{
		"什么声音？",		--蚁狮地震
		"是马达吗？",		--蚁狮地震
		"听起来好厉害",		--蚁狮地震
	},
	ANNOUNCE_ANTLION_TRIBUTE =
	{
        "这次先放过你",		--向蚁狮致敬
        "给我舔脚吧蚂蚁！",		--给蚁狮上供
        "臭杂鱼，再搞事踩爆你的头",		--给蚁狮上供
	},
	ANNOUNCE_SACREDCHEST_YES = "好耶！",		--远古宝箱物品正确给出蓝图
	ANNOUNCE_SACREDCHEST_NO = "犀牛死前拉出了这个大箱子",		--远古宝箱
    ANNOUNCE_DUSK = "天要黑了，我要去睡觉了",		--进入黄昏
	ANNOUNCE_EAT =
	{
		GENERIC = "嚼嚼嚼!",		--吃东西
		PAINFUL = "硌到牙了…",		--吃怪物肉
		SPOILED = "偷偷吃屎不会有人发现吧",		--吃腐烂食物
		STALE = "烂了！不能吃了！",		--吃黄色食物
		INVALID = "看着就好吃。",		--拒吃
        YUCKY = "yue了",		--吃红色食物
    },
    ANNOUNCE_ENCUMBERED =
    {
        "嘿……",		--搬运雕像、可疑的大理石
        "好重……",		--搬运雕像、可疑的大理石
        "好累吖……",		--搬运雕像、可疑的大理石
        "哥哥，帮帮人家吧……",		--搬运雕像、可疑的大理石
        "重，太重了……",		--搬运雕像、可疑的大理石
        "…………",		--搬运雕像、可疑的大理石
        "要累死了啦！",		--搬运雕像、可疑的大理石
    },
    ANNOUNCE_ATRIUM_DESTABILIZING = 
    {
		"那些齿轮和宝石都要回来了",		--中庭击杀boss后即将刷新
		"听起来就好厉害！",		--中庭震动
		"快去掏犀牛皮鼓，里面有好东西！",		--中庭击杀boss后即将刷新
	},
    ANNOUNCE_RUINS_RESET = "可以去拿宝石了",		--地下重置
    ANNOUNCE_SNARED = "轻点啦~",		--远古嘤嘤怪的骨笼
    ANNOUNCE_REPELLED = "啊？你玩赖的！",		--嘤嘤怪保护状态
	ANNOUNCE_ENTER_DARK = "天黑了喔",		--进入黑暗
	ANNOUNCE_ENTER_LIGHT = "天亮了喔",		--进入光源
	ANNOUNCE_FREEDOM = "再见咯！",		--没调用（废案）
	ANNOUNCE_HIGHRESEARCH = "感觉脑瓜聪明透顶！",		--没调用（废案）
	ANNOUNCE_HOUNDS = "啊！总是这样玩着玩着就有狗开始叫了！",		--猎犬将至
	ANNOUNCE_WORMS = "小泥鳅钻钻钻",		--蠕虫袭击
	ANNOUNCE_HUNGRY = "饿饿，饭饭",		--饥饿
	ANNOUNCE_HUNT_BEAST_NEARBY = "大象大象！",		--即将找到野兽
	ANNOUNCE_HUNT_LOST_TRAIL = "跑掉了喔！",		--猎物（大象脚印丢失）
	ANNOUNCE_HUNT_LOST_TRAIL_SPRING = "脚印消失了",		--大猎物丢失踪迹
	ANNOUNCE_INV_FULL = "就不能给人家一个大一点的包包嘛？",		--身上的物品满了
	ANNOUNCE_KNOCKEDOUT = "好累啊，人家要睡着了。。zzzzz",		--被催眠
	ANNOUNCE_LOWRESEARCH = "理解不了……",		--没调用（废案）
	ANNOUNCE_MOSQUITOS = "！走开，虫子们！",		--没调用
    ANNOUNCE_NOWARDROBEONFIRE = "燃起来了！",		--橱柜着火
    ANNOUNCE_NODANGERGIFT = "我的快递，绝对绝对不能被人看到",		--周围有危险的情况下打开礼物
    ANNOUNCE_NOMOUNTEDGIFT = "我的快递被牛牛看到的话该学坏了喔",		--骑牛的时候打开礼物
	ANNOUNCE_NODANGERSLEEP = "不能。。。睡着。。（zzzzz）",		--危险，不能睡觉
	ANNOUNCE_NODAYSLEEP = "那是晚上才能干的事啦",		--白天睡帐篷
	ANNOUNCE_NODAYSLEEP_CAVE = "那是晚上才能干的事啦",		--洞穴里白天睡帐篷
	ANNOUNCE_NOHUNGERSLEEP = "饿饿，人家要饭饭！",		--饿了无法睡觉
	ANNOUNCE_NOSLEEPONFIRE = "着火啦，我的快乐小屋！",		--营帐着火无法睡觉
	ANNOUNCE_NODANGERSIESTA = "有人在惦记人家，好可怕",		--危险，不能午睡
	ANNOUNCE_NONIGHTSIESTA = "没帘子怎么睡啊！",		--夜晚睡凉棚
	ANNOUNCE_NONIGHTSIESTA_CAVE = "好寂寞，要是捂耳姐姐在就好了。",		--在洞穴里夜晚睡凉棚
	ANNOUNCE_NOHUNGERSIESTA = "饿饿，人家要饭饭！",		--饱度不足无法午睡
	ANNOUNCE_NODANGERAFK = "得小心！",		--战斗状态下线（已经移除）
	ANNOUNCE_NO_TRAP = "容易！",		--没有陷阱？？？没调用
	ANNOUNCE_PECKED = "哭哭，我好菜，小鸟都欺负我！",		--被小高鸟啄
	ANNOUNCE_QUAKE = "晃得脑袋晕晕的！",		--地震
	ANNOUNCE_RESEARCH = "感觉脑瓜聪明透顶！",		--没调用
	ANNOUNCE_SHELTER = "下雨了要躲雨！",		--下雨天躲树下
	ANNOUNCE_THORNS = "有刺刺，扎手手！",		--玫瑰、仙人掌、荆棘扎手
	ANNOUNCE_BURNT = "真是有够烧的",		--烧完了
	ANNOUNCE_TORCH_OUT = "哦豁，没了",		--火把用完了
	ANNOUNCE_THURIBLE_OUT = "它烧洗了。",		--香炉燃尽
	ANNOUNCE_FAN_OUT = "哦豁，没了。",		--小风车停了
    ANNOUNCE_COMPASS_OUT = "哦豁，没了",		--指南针用完了
	ANNOUNCE_TRAP_WENT_OFF = "怕怕",		--触发陷阱（例如冬季陷阱）
	ANNOUNCE_UNIMPLEMENTED = "陷阱没好！",		--没调用
	ANNOUNCE_WORMHOLE = "里面软软的",		--跳虫洞
	ANNOUNCE_TOWNPORTALTELEPORT = "芜湖~！",		--豪华传送
	ANNOUNCE_CANFIX = "修修~",		--墙壁可以修理
	ANNOUNCE_ACCOMPLISHMENT = "搞定！",		--没调用
	ANNOUNCE_ACCOMPLISHMENT_DONE = "搞定！",			--没调用
	ANNOUNCE_INSUFFICIENTFERTILIZER = "它痿了。",		--土地肥力不足
	ANNOUNCE_TOOL_SLIP = "啊呀，好滑，人家都抓不住了呢~",		--工具滑出
	ANNOUNCE_LIGHTNING_DAMAGE_AVOIDED = "酥酥麻麻",		--规避闪电
	ANNOUNCE_TOADESCAPING = "臭蛙蛙要跑路了",		--蟾蜍正在逃跑
	ANNOUNCE_TOADESCAPED = "臭蛙蛙回家了。",		--蟾蜍逃走了
	ANNOUNCE_DAMP = "有点湿湿。",		--潮湿（1级）
	ANNOUNCE_WET = "身上好湿湿。",		--潮湿（2级）
	ANNOUNCE_WETTER = "人家湿透了啦。",		--潮湿（3级）
	ANNOUNCE_SOAKED = "全是水，要不行了。",		--潮湿（4级）
	ANNOUNCE_WASHED_ASHORE = "我……没穿泳衣",		--暂无注释
    ANNOUNCE_DESPAWN = "吃个饭饭就来……",		--下线
	ANNOUNCE_BECOMEGHOST = "那么大家贵安，我们来世再见吧……",		--变成鬼魂
	ANNOUNCE_GHOSTDRAIN = "铸币队友能不能死一死啊，哦已经死了",		--队友死亡掉san
	ANNOUNCE_PETRIFED_TREES = "挖挖挖",		--石化树
	ANNOUNCE_KLAUS_ENRAGE = "我们几个中出了一头猪",		--克劳斯被激怒（杀死了鹿）
	ANNOUNCE_KLAUS_UNCHAINED = "大复活术！",		--克劳斯-未上锁的  猜测是死亡准备变身？
	ANNOUNCE_KLAUS_CALLFORHELP = "你躲不掉的",		--克劳斯召唤小偷
	ANNOUNCE_MOONALTAR_MINE =
	{
		GLASS_MED = "里面有东西？",		--暂无注释
		GLASS_LOW = "快好了！",		--暂无注释
		GLASS_REVEAL = "你自由了！",		--暂无注释
		IDOL_MED = "里面有东西？",		--暂无注释
		IDOL_LOW = "快好了！",		--暂无注释
		IDOL_REVEAL = "你自由了！",		--暂无注释
		SEED_MED = "里面有东西？",		--暂无注释
		SEED_LOW = "快好了！",		--暂无注释
		SEED_REVEAL = "你自由了！",		--暂无注释
	},
    ANNOUNCE_SPOOKED = "好可怕",		--被吓到
	ANNOUNCE_BRAVERY_POTION = "赋予勇气",		--勇气药剂
	ANNOUNCE_MOONPOTION_FAILED = "好像什么都没发生",		--暂无注释
	ANNOUNCE_EATING_NOT_FEASTING = "我应该跟其他人一起分享",		--暂无注释
	ANNOUNCE_WINTERS_FEAST_BUFF = "感觉亮闪闪的",		--暂无注释
	ANNOUNCE_IS_FEASTING = "好多吃的！",		--暂无注释
	ANNOUNCE_WINTERS_FEAST_BUFF_OVER = "闪亮的东西去哪了？",		--暂无注释
    ANNOUNCE_REVIVING_CORPSE = "我们是朋友了……？",		--没调用（熔炉）
    ANNOUNCE_REVIVED_OTHER_CORPSE = "好多了！",		--没调用（熔炉）
    ANNOUNCE_REVIVED_FROM_CORPSE = "-真吓人",		--没调用（熔炉）
    ANNOUNCE_FLARE_SEEN = "天空着火了？？",		--暂无注释
    ANNOUNCE_OCEAN_SILHOUETTE_INCOMING = "有人要来吗？",		--暂无注释
    ANNOUNCE_ROYALTY =
    {
        "我怎么会向猪比低头！",		--向带着蜂王帽的队友鞠躬
        "被硬控了，后面会失守的啊！！",		--向带着蜂王帽的队友鞠躬
        "（摸摸）狗狗好乖~",		--向带着蜂王帽的队友鞠躬
    },
    ANNOUNCE_ATTACH_BUFF_ELECTRICATTACK    = "酥酥麻麻的！",		--暂无注释
    ANNOUNCE_ATTACH_BUFF_ATTACK            = "干就完事了！",		--暂无注释
    ANNOUNCE_ATTACH_BUFF_PLAYERABSORPTION  = "不服干我！",		--暂无注释
    ANNOUNCE_ATTACH_BUFF_WORKEFFECTIVENESS = "突然想干活了!",		--暂无注释
    ANNOUNCE_ATTACH_BUFF_MOISTUREIMMUNITY  = "身体变的干巴巴了……",		--暂无注释
    ANNOUNCE_DETACH_BUFF_ELECTRICATTACK    = "酥酥麻麻的感觉消失了",		--暂无注释
    ANNOUNCE_DETACH_BUFF_ATTACK            = "干不动了！",		--暂无注释
    ANNOUNCE_DETACH_BUFF_PLAYERABSORPTION  = "不要了，人家不要了！",		--暂无注释
    ANNOUNCE_DETACH_BUFF_WORKEFFECTIVENESS = "累了……",		--暂无注释
    ANNOUNCE_DETACH_BUFF_MOISTUREIMMUNITY  = "湿起来惹！",		--暂无注释
	ANNOUNCE_OCEANFISHING_LINESNAP = "嘿！",		--暂无注释
	ANNOUNCE_OCEANFISHING_LINETOOLOOSE = "空军了！",		--暂无注释
	ANNOUNCE_OCEANFISHING_GOTAWAY = "给机会不要是吧，那别怪我了！",		--暂无注释
	ANNOUNCE_OCEANFISHING_BADCAST = "好难。。。",		--暂无注释
	ANNOUNCE_OCEANFISHING_IDLE_QUOTE = 
	{
		"小鱼！过来，小鱼！",		--暂无注释
		"嘟嘀嗒……",		--暂无注释
		"鱼儿呢？",		--暂无注释
		"有点久",		--暂无注释
	},
	ANNOUNCE_WEIGHT = "重量：{weight}：就这？",		--暂无注释
    ANNOUNCE_KINGCREATED = "鱼人有了新国王！",		--暂无注释
    ANNOUNCE_KINGDESTROYED = "上一届国王不行，放心有人会找一个更好的！",		--暂无注释
    ANNOUNCE_CANTBUILDHERE_THRONE = "这地方不适合沼泽的王！",		--暂无注释
    ANNOUNCE_CANTBUILDHERE_HOUSE = "壮观！",		--暂无注释
    ANNOUNCE_CANTBUILDHERE_WATCHTOWER = "卫士保护好这里！",		--暂无注释
    ANNOUNCE_READ_BOOK = 
    {
        BOOK_SLEEP = "很久很久！以前……",		--暂无注释
        BOOK_BIRDS = "有没有帮助织女姐姐的喜鹊呢？",		--暂无注释
        BOOK_TENTACLES =  "这是本好书！",		--暂无注释
        BOOK_BRIMSTONE = "想知道故事的结尾！",		--暂无注释
        BOOK_GARDENING = "好多生僻字……",		--暂无注释
    },
    ANNOUNCE_WEAK_RAT = "看着不太适合……",		--暂无注释
    ANNOUNCE_CARRAT_START_RACE = "冲！",		--暂无注释
    ANNOUNCE_CARRAT_ERROR_WRONG_WAY = 
    {
        "不是往那边跑！那边！",		--暂无注释
        "萝卜鼠跑错方向了！",		--暂无注释
    },
    ANNOUNCE_CARRAT_ERROR_FELL_ASLEEP = "别睡觉了，快起来！",    		--暂无注释
    ANNOUNCE_CARRAT_ERROR_WALKING = "跑的不够快，加油！",    		--暂无注释
    ANNOUNCE_CARRAT_ERROR_STUNNED = "你怎么了？怎么不动了？！",		--暂无注释
    ANNOUNCE_GHOST_QUEST = "这个物品是别人的",		--暂无注释
    ANNOUNCE_ABIGAIL_SUMMON = 
	{
	},
    ANNOUNCE_GHOSTLYBOND_LEVELUP = 
	{
	},
	BATTLECRY =
	{
		GENERIC = "臣服在我的脚下吧！",		--战斗
		PIG = "偷偷割知非二两肉吃！",		--战斗 猪人
		PREY = "肉肉，都是肉肉！",		--战斗 猎物？？大象？
		SPIDER = "狠狠的踩头",		--战斗 蜘蛛
		SPIDER_WARRIOR = "小黄蛛蛛踩踩踩",		--战斗 蜘蛛战士
		DEER = "不是我打的你哦",		--战斗 无眼鹿
	},
	COMBAT_QUIT =
	{
		GENERIC = "他被困住了！",		--攻击目标被卡住，无法攻击
		PIG = "跑吧，快跑吧，离开这里",		--退出战斗-猪人
		PREY = "你走不了",		--退出战斗 猎物？？大象？
		SPIDER = "好烦，终于远离了",		-- 退出战斗 蜘蛛
		SPIDER_WARRIOR = "好烦，终于远离了！",		--退出战斗 蜘蛛战士
	},
	DESCRIBE =
	{
		MULTIPLAYER_PORTAL = "小心，有猪出没",		-- 物品名:"绚丽之门"
        MULTIPLAYER_PORTAL_MOONROCK = "小心，不止有猪出没",		-- 物品名:"天体传送门"
        MOONROCKIDOL = "感觉它在看着我",		-- 物品名:"月岩雕像" 制造描述:"重要人物"
        CONSTRUCTION_PLANS = "应该很容易做！",		-- 物品名:未找到
        ANTLION =
        {
            GENERIC = "你想要我就给你？",		-- 物品名:"蚁狮"->默认
            VERYHAPPY = "它满足了！",		-- 物品名:"蚁狮"
            UNHAPPY = "它想要了！",		-- 物品名:"蚁狮"
        },
        ANTLIONTRINKET = "看样子是个马桶！",		-- 物品名:"沙滩玩具"
        SANDSPIKE = "扎到会不会很痛",		-- 物品名:"沙刺"
        SANDBLOCK = "沙雕!",		-- 物品名:"沙堡"
        GLASSSPIKE = "闪闪亮狼牙棒！",		-- 物品名:"玻璃狼牙棒"
        GLASSBLOCK = "闪闪亮城堡",		-- 物品名:"玻璃城堡"
        ABIGAIL_FLOWER =
        {
            GENERIC ="蕴藏灵魂之花",		-- 物品名:"阿比盖尔之花"->默认 制造描述:"一个神奇的纪念品"
			LEVEL1 = "阿比盖尔躲起来了",		-- 物品名:"阿比盖尔之花" 制造描述:"一个神奇的纪念品"
			LEVEL2 = "她还真是慢慢悠悠",		-- 物品名:"阿比盖尔之花" 制造描述:"一个神奇的纪念品"
			LEVEL3 = "出来！",		-- 物品名:"阿比盖尔之花" 制造描述:"一个神奇的纪念品"
            LONG = "真漂亮",		-- 物品名:"阿比盖尔之花"->还需要很久 制造描述:"一个神奇的纪念品"
            MEDIUM = "嘿？",		-- 物品名:"阿比盖尔之花" 制造描述:"一个神奇的纪念品"
            SOON = "有什么事要发生了？",		-- 物品名:"阿比盖尔之花" 制造描述:"一个神奇的纪念品"
            HAUNTED_POCKET = "下去",		-- 物品名:"阿比盖尔之花" 制造描述:"一个神奇的纪念品"
            HAUNTED_GROUND = "不该出现在这的……",		-- 物品名:"阿比盖尔之花" 制造描述:"一个神奇的纪念品"
        },
        BALLOONS_EMPTY = "看起来很漂亮",		-- 物品名:"韦斯的气球" 制造描述:"要是有更简单的方法该多好"
        BALLOON = "好漂亮的气球",		-- 物品名:"气球"
        BERNIE_INACTIVE =
        {
            BROKEN = "可以驱逐暗影的大熊",		-- 物品名:"伯尼" 制造描述:"这个疯狂的世界总有你熟悉的人"
            GENERIC = "不想玩了吗？",		-- 物品名:"伯尼"->默认 制造描述:"这个疯狂的世界总有你熟悉的人"
        },
        BERNIE_ACTIVE = "想和它玩！",		-- 物品名:"伯尼"
        BERNIE_BIG = "好玩的玩具!",		-- 物品名:"伯尼！"
        BOOK_BIRDS = "这本书是让分离的鸟儿们再次相聚",		-- 物品名:"世界鸟类手册" 制造描述:"涵盖1000个物种：习性、栖息地及叫声"
        BOOK_TENTACLES = "他们要从地下出来了",		-- 物品名:"触手的召唤" 制造描述:"让我们来了解一下地下的朋友们！"
        BOOK_GARDENING = "好神奇的书！",		-- 物品名:"应用园艺学" 制造描述:"讲述培育和照料植物的相关知识"
        BOOK_SLEEP = "这可以让我放心入睡",		-- 物品名:"睡前故事" 制造描述:"送你入梦的睡前故事"
        BOOK_BRIMSTONE = "比闪电弱一点的东西",		-- 物品名:"末日将至！" 制造描述:"世界将在火焰和灾难中终结！"
        PLAYER =
        {
            GENERIC = "你好吖， %s，宝贝，我是你的新妈妈！!",		-- 物品名:未找到
            ATTACKER = "呜呜呜，我被猪打了！！就是它， %s",		-- 物品名:未找到
            MURDERER = "………… %s 你就是猪吧！！ ",		-- 物品名:未找到
            REVIVER = "这可以拿来复活猪比！",		-- 物品名:"告密的心" 制造描述:"鬼魂朋友复活了，好可怕"
            GHOST = "你是真人吗？！， %s",		-- 物品名:"幽灵"
            FIRESTARTER = "猪也会怕冷？ %s!!",		-- 物品名:未找到
        },
        WILSON =
        {
            GENERIC = "你好，威吊！",		-- 物品名:"威尔逊"->默认
            ATTACKER = "这样不好啊！",		-- 物品名:"威尔逊"
            MURDERER = "就知道不能信任！",		-- 物品名:"威尔逊"
            REVIVER = "那个 \"科学\" 挺不错, ",		-- 物品名:"告密的心" 制造描述:"鬼魂朋友复活了，好可怕"
            GHOST = "嘿嘿，你看着有点傻！",		-- 物品名:"幽灵"
            FIRESTARTER = "这样是为了 \" 科学\"？",		-- 物品名:"威尔逊"
        },
        WOLFGANG =
        {
            GENERIC = "你好，土豆人！",		-- 物品名:"沃尔夫冈"->默认
            ATTACKER = "不公平，你个头大很多！",		-- 物品名:"沃尔夫冈"
            MURDERER = "你这个恶霸！",		-- 物品名:"沃尔夫冈"
            REVIVER = "所以你不再怕我了吗？",		-- 物品名:"告密的心" 制造描述:"鬼魂朋友复活了，好可怕"
            GHOST = "别害怕，我会给你找颗心！",		-- 物品名:"幽灵"
            FIRESTARTER = "这是个馊点子",		-- 物品名:"沃尔夫冈"
        },
        WAXWELL =
        {
            GENERIC = "你好，工具人",		-- 物品名:"麦斯威尔"->默认
            ATTACKER = "你这个坏蛋！！",		-- 物品名:"麦斯威尔"
            MURDERER = "我知道为什么也不喜欢你了",		-- 物品名:"麦斯威尔"
            REVIVER = "你好像也没那么坏",		-- 物品名:"告密的心" 制造描述:"鬼魂朋友复活了，好可怕"
            GHOST = "别闹，我会帮你的！",		-- 物品名:"幽灵"
            FIRESTARTER = "他干的！他干的！",		-- 物品名:"麦斯威尔"
        },
        WX78 =
        {
            GENERIC = "你好，齿轮人",		-- 物品名:"WX-78"->默认
            ATTACKER = "嗷！住手！",		-- 物品名:"WX-78"
            MURDERER = "残酷的战争！",		-- 物品名:"WX-78"
            REVIVER = "没想到你会这样做……",		-- 物品名:"告密的心" 制造描述:"鬼魂朋友复活了，好可怕"
            GHOST = "你看起来不怎么高兴",		-- 物品名:"幽灵"
            FIRESTARTER = "你玩的过火了",		-- 物品名:"WX-78"
        },
        WILLOW =
        {
            GENERIC = "你好，火机人！",		-- 物品名:"薇洛"->默认
            ATTACKER = "你们也不是那么硬！",		-- 物品名:"薇洛"
            MURDERER = "坏女士！",		-- 物品名:"薇洛"
            REVIVER = "你人其实挺好的",		-- 物品名:"告密的心" 制造描述:"鬼魂朋友复活了，好可怕"
            GHOST = "反正你都……就换我陪小熊玩吧？好吧，我去找颗心",		-- 物品名:"幽灵"
            FIRESTARTER = "她好像挺开心的",		-- 物品名:"薇洛"
        },
        WENDY =
        {
            GENERIC = "你好，TOOSTRONG？？",		-- 物品名:"温蒂"->默认
            ATTACKER = "嘿！停手！",		-- 物品名:"温蒂"
            MURDERER = "你只想跟鬼魂玩？",		-- 物品名:"温蒂"
            REVIVER = "替你跟阿比盖饵打招呼了",		-- 物品名:"告密的心" 制造描述:"鬼魂朋友复活了，好可怕"
            GHOST = "你……真的想要一颗心吗？",		-- 物品名:"幽灵"
            FIRESTARTER = "你为什么那么做？",		-- 物品名:"温蒂"
        },
        WOODIE =
        {
            GENERIC = "你好,纯鹿人！",		-- 物品名:"伍迪"->默认
            ATTACKER = "去找棵树打，别打人！",		-- 物品名:"伍迪"
            MURDERER = "早就该料到伐木先生是杀手的！",		-- 物品名:"伍迪"
            REVIVER = "伐木先生人很好",		-- 物品名:"告密的心" 制造描述:"鬼魂朋友复活了，好可怕"
            GHOST = "需要帮忙吗？",		-- 物品名:"幽灵"
            BEAVER = "砍树的那个人去哪了？！",		-- 物品名:"伍迪"
            BEAVERGHOST = "我会找颗心的，你要把伐木先生带回来！",		-- 物品名:"伍迪"
            MOOSE = "砍树的那个人去哪了？！",		-- 物品名:"伍迪"
            MOOSEGHOST = "我会找颗心的，你要把伐木先生带回来！",		-- 物品名:"伍迪"
            GOOSE = "砍树的那个人去哪了？！",		-- 物品名:"伍迪"
            GOOSEGHOST = "我会找颗心的，你要把伐木先生带回来！",		-- 物品名:"伍迪"
            FIRESTARTER = "你不是喜欢砍树吗，怎么又烧东西？",		-- 物品名:"伍迪"
        },
        WICKERBOTTOM =
        {
            GENERIC = "oi，老登？",		-- 物品名:"薇克巴顿"->默认
            ATTACKER = "生什么气？我什么也没做！",		-- 物品名:"薇克巴顿"
            MURDERER = "亏我那么信任你！",		-- 物品名:"薇克巴顿"
            REVIVER = "非常感谢！（我说对了吗）",		-- 物品名:"告密的心" 制造描述:"鬼魂朋友复活了，好可怕"
            GHOST = "马上就给你弄颗心！",		-- 物品名:"幽灵"
            FIRESTARTER = "不要到处点营火",		-- 物品名:"薇克巴顿"
        },
        WES =
        {
            GENERIC = "你好，气球人",		-- 物品名:"韦斯"->默认
            ATTACKER = "，走开！",		-- 物品名:"韦斯"
            MURDERER = "当初就不该离开那里！",		-- 物品名:"韦斯"
            REVIVER = "喔……谢谢",		-- 物品名:"告密的心" 制造描述:"鬼魂朋友复活了，好可怕"
            GHOST = "比平时还苍白",		-- 物品名:"幽灵"
            FIRESTARTER = "你是个怪人",		-- 物品名:"韦斯"
        },
        WEBBER =
        {
            GENERIC = "嗨，让我把脚放在你毛茸茸的脸上摩擦好吗？",		-- 物品名:"韦伯"->默认
            ATTACKER = "你干嘛这么刻薄？",		-- 物品名:"韦伯"
            MURDERER = "以为你是朋友呢！",		-- 物品名:"韦伯"
            REVIVER = "就知道我们是朋友！",		-- 物品名:"告密的心" 制造描述:"鬼魂朋友复活了，好可怕"
            GHOST = "别难过，会给你找颗心！",		-- 物品名:"幽灵"
            FIRESTARTER = "你会惹上麻烦的！",		-- 物品名:"韦伯"
        },
        WATHGRITHR =
        {
            GENERIC = "你好，战歌人！",		-- 物品名:"薇弗德"->默认
            ATTACKER = "维京女士想打一架？？",		-- 物品名:"薇弗德"
            MURDERER = "可别猎杀我！！",		-- 物品名:"薇弗德"
            REVIVER = "……谢谢你",		-- 物品名:"告密的心" 制造描述:"鬼魂朋友复活了，好可怕"
            GHOST = "喔，你看着好吓人！",		-- 物品名:"幽灵"
            FIRESTARTER = "那不是火焰女士的工作吗",		-- 物品名:"薇弗德"
        },
        WINONA =
        {
            GENERIC = "听说你可以盾反查理？",		-- 物品名:"薇诺娜"->默认
            ATTACKER = "那个不安全！",		-- 物品名:"薇诺娜"
            MURDERER = "你辜负了我的信任！！",		-- 物品名:"薇诺娜"
            REVIVER = "都修好了！",		-- 物品名:"告密的心" 制造描述:"鬼魂朋友复活了，好可怕"
            GHOST = "本以为你从来不开小差呢？",		-- 物品名:"幽灵"
            FIRESTARTER = "也许她厌倦修东西了",		-- 物品名:"薇诺娜"
        },
        WORTOX =
        {
            GENERIC = "恶魔，你有没有恶魔吐司？",		-- 物品名:"沃拓克斯"->默认
            ATTACKER = "你真是个坏蛋！",		-- 物品名:"沃拓克斯"
            MURDERER = "就知道你信不过！",		-- 物品名:"沃拓克斯"
            REVIVER = "又在捣鬼……？",		-- 物品名:"告密的心" 制造描述:"鬼魂朋友复活了，好可怕"
            GHOST = "噗嗤一声你就灵魂出窍了！！",		-- 物品名:"幽灵"
            FIRESTARTER = "它看着好吓人",		-- 物品名:"沃拓克斯"
        },
        WORMWOOD =
        {
            GENERIC = "草，一种植物！",		-- 物品名:"沃姆伍德"->默认
            ATTACKER = "嗷！你这个又老又坏的杂草！",		-- 物品名:"沃姆伍德"
            MURDERER = "我们做不了朋友了！",		-- 物品名:"沃姆伍德"
            REVIVER = "你是颗好植物！",		-- 物品名:"告密的心" 制造描述:"鬼魂朋友复活了，好可怕"
            GHOST = "你在这等着！我去找人帮忙！",		-- 物品名:"幽灵"
            FIRESTARTER = "闻到香味了，你可以把自己也烤了嘛？",		-- 物品名:"沃姆伍德"
        },
        WARLY =
        {
            GENERIC = "我超，厨子！",		-- 物品名:"沃利"->默认
            ATTACKER = "还以为你是个好人呢！",		-- 物品名:"沃利"
            MURDERER = "你根本就不算朋友！",		-- 物品名:"沃利"
            REVIVER = "你……帮我？",		-- 物品名:"告密的心" 制造描述:"鬼魂朋友复活了，好可怕"
            GHOST = "不！以后谁给我做好吃的……",		-- 物品名:"幽灵"
            FIRESTARTER = "他什么都想烧来吃！",		-- 物品名:"沃利"
        },
        WURT =
        {
            GENERIC = "你好啊，小鱼人!",		-- 物品名:"沃特"->默认
            ATTACKER = "我们应该团结！",		-- 物品名:"沃特"
            MURDERER = "果然最大的敌人！",		-- 物品名:"沃特"
            REVIVER = "我永远靠谱！",		-- 物品名:"告密的心" 制造描述:"鬼魂朋友复活了，好可怕"
            GHOST = "某个地方应该能找到颗心",		-- 物品名:"幽灵"
            FIRESTARTER = "停手！你会让我们惹上麻烦的！",		-- 物品名:"沃特"
        },
        MIGRATION_PORTAL =
        {
            GENERIC = "麦……麦当劳？",		-- 物品名:"Matic 朋友之门"->默认
            OPEN = "不知道另一边有什么……",		-- 物品名:"Matic 朋友之门"->打开
            FULL = "没有空位",		-- 物品名:"Matic 朋友之门"->满了
        },
        GLOMMER = 
        {
            GENERIC = "一只会飞的小非猪，简称 只飞猪",		-- 物品名:"罗姆"->默认
            SLEEPING = "宠物小非猪睡着了",		-- 物品名:"罗姆"->睡着了
        },
        GLOMMERFLOWER =
        {
            GENERIC = "我一定会保护好你的",		-- 物品名:"罗姆花"->默认
            DEAD = "我说着玩的",		-- 物品名:"罗姆花"->死了
        },
        GLOMMERWINGS = "它的翅膀",		-- 物品名:"罗姆翅膀"
        GLOMMERFUEL = "黏黏的，我也有哦",		-- 物品名:"罗姆的黏液"
        BELL = "叮铃铃",		-- 物品名:"远古铃铛" 制造描述:"这可不是普通的铃铛"
        STATUEGLOMMER =
        {
            GENERIC = "小飞猪的雕像",		-- 物品名:"罗姆雕像"->默认
            EMPTY = "被人毁了！",		-- 物品名:"罗姆雕像"
        },
        LAVA_POND_ROCK = "石头的一部分",		-- 物品名:"岩石"
		WEBBERSKULL = "骨头不该放那里！",		-- 物品名:"韦伯的头骨"
		WORMLIGHT = "亮闪闪的果子",		-- 物品名:"发光蓝莓"
		WORMLIGHT_LESSER = "吃了它，身体会发光",		-- 物品名:"较少发光蓝莓"
		WORM =
		{
		    PLANT = "小泥鳅，一脚一个",		-- 物品名:"洞穴蠕虫"
		    DIRT = "下面有着一只恐怖的大虫子",		-- 物品名:"洞穴蠕虫"
		    WORM = "我可不怕",		-- 物品名:"洞穴蠕虫"
		},
        WORMLIGHT_PLANT = "美丽",		-- 物品名:"神秘植物"
		MOLE =
		{
			HELD = "听说你喜欢吃石？",		-- 物品名:"鼹鼠"->拿在手里
			UNDERGROUND = "可可爱爱，没有脑袋",		-- 物品名:"鼹鼠"
			ABOVEGROUND = "可可爱爱，没有脑袋",		-- 物品名:"鼹鼠"
		},
		MOLEHILL = "鼹鼠的小穴",		-- 物品名:"鼹鼠丘"
		MOLEHAT = "鼹鼠的腹腔套在了头上。",		-- 物品名:"鼹鼠帽" 制造描述:"为穿戴者提供夜视能力"
		EEL = "我有个大胆的想法",		-- 物品名:"鳗鱼"
		EEL_COOKED = "玩完了还能吃",		-- 物品名:"烤鳗鱼"
		UNAGI = "加点草莓酱就更好了",		-- 物品名:"鳗鱼料理"
		EYETURRET = "你怎么偷偷看人家？",		-- 物品名:"眼睛炮塔"
		EYETURRET_ITEM = "这样是正确的吗",		-- 物品名:"眼睛炮塔" 制造描述:"要远离讨厌的东西，就得杀了它们"
		MINOTAURHORN = "顶人好痛的",		-- 物品名:"守护者之角"
		MINOTAURCHEST = "犀牛失禁拉出来的吗",		-- 物品名:"大号华丽箱子"
		THULECITE_PIECES = "这是铥矿的碎片",		-- 物品名:"铥矿碎片"
		POND_ALGAE = "湿湿的",		-- 物品名:"水藻"
		GREENSTAFF = "刷刷刷！",		-- 物品名:"拆解魔杖" 制造描述:"干净而有效的摧毁"
		GIFT = "可以送给阿鹿！",		-- 物品名:"礼物"
        GIFTWRAP = "可以做礼物送给大家！",		-- 物品名:"礼物包装" 制造描述:"把东西打包起来，好看又可爱！"
		POTTEDFERN = "生机勃勃",		-- 物品名:"蕨类盆栽" 制造描述:"做个花盆，里面栽上蕨类植物"
        SUCCULENT_POTTED = "生机勃勃",		-- 物品名:"多肉盆栽" 制造描述:"塞进陶盆的漂亮多肉植物"
		SUCCULENT_PLANT = "热带植物",		-- 物品名:"多肉植物"
		SUCCULENT_PICKED = "好看",		-- 物品名:"多肉植物"
		SENTRYWARD = "清辉月华",		-- 物品名:"月眼守卫" 制造描述:"绘图者最有价值的武器"
        TOWNPORTAL =
        {
			GENERIC = "我们一起同行吧",		-- 物品名:"强征传送塔"->默认 制造描述:"用沙子的力量聚集你的朋友们"
			ACTIVE = "随我同行",		-- 物品名:"强征传送塔"->激活了 制造描述:"用沙子的力量聚集你的朋友们"
		},
        TOWNPORTALTALISMAN = 
        {
			GENERIC = "新玩具！",		-- 物品名:"沙漠石头"->默认
			ACTIVE = "好玩",		-- 物品名:"沙漠石头"->激活了
		},
        WETPAPER = "承载着知识",		-- 物品名:"纸张"
        WETPOUCH = "这是池塘中的刮刮卡",		-- 物品名:"起皱的包裹"
        MOONROCK_PIECES = "月亮的碎块",		-- 物品名:"月亮石碎块"
        MOONBASE =
        {
            GENERIC = "月亮上的石块",		-- 物品名:"月亮石"->默认
            BROKEN = "碎掉惹！",		-- 物品名:"月亮石"
            STAFFED = "裂开惹！",		-- 物品名:"月亮石"
            WRONGSTAFF = "生殖隔离！",		-- 物品名:"月亮石"->插错法杖
            MOONSTAFF = "成功惹！",		-- 物品名:"月亮石"->已经插了法杖的（月杖）
        },
        MOONDIAL = 
        {
			GENERIC = "探索漂亮的月亮",		-- 物品名:"月晷"->默认 制造描述:"追踪月相！"
			NIGHT_NEW = "首先排除这是满月！",		-- 物品名:"月晷"->新月 制造描述:"追踪月相！"
			NIGHT_WAX = "半拉月亮",		-- 物品名:"月晷"->上弦月 制造描述:"追踪月相！"
			NIGHT_FULL = "首先排除这是新月！",		-- 物品名:"月晷"->满月 制造描述:"追踪月相！"
			NIGHT_WANE = "半拉月亮",		-- 物品名:"月晷"->下弦月 制造描述:"追踪月相！"
			CAVE = "你是真人吗，在这里看月相",		-- 物品名:"月晷"->洞穴 制造描述:"追踪月相！"
        },
		THULECITE = "我铥！",		-- 物品名:"铥矿石" 制造描述:"将小碎片合成一大块"
		ARMORRUINS = "我勒个铥！！",		-- 物品名:"铥矿甲" 制造描述:"炫目并且能提供保护"
		ARMORSKELETON = "排骨盔甲！",		-- 物品名:"骨头盔甲"
		SKELETONHAT = "头晕眼花~~",		-- 物品名:"骨头头盔"
		RUINS_BAT = "给你牙打歪",		-- 物品名:"铥矿岩棒" 制造描述:"尖钉让一切变得更好"
		RUINSHAT = "我就是王，现在跪下认错舔我的脚还来得及！",		-- 物品名:"远古王冠" 制造描述:"附有远古力场！"
		NIGHTMARE_TIMEPIECE =
		{
            CALM = "安全期",		-- 物品名:"铥矿奖章" 制造描述:"跟踪周围魔力水平的流动"
            WARN = "来感觉了",		-- 物品名:"铥矿奖章" 制造描述:"跟踪周围魔力水平的流动"
            WAXING = "要高潮了",		-- 物品名:"铥矿奖章" 制造描述:"跟踪周围魔力水平的流动"
            STEADY = "不要，停",  	-- 物品名:"铥矿奖章" 制造描述:"跟踪周围魔力水平的流动"
            WANING = "快结束了",		-- 物品名:"铥矿奖章" 制造描述:"跟踪周围魔力水平的流动"
            DAWN = "终于结束了",		-- 物品名:"铥矿奖章" 制造描述:"跟踪周围魔力水平的流动"
            NOMAGIC = "一点也没有了嘛？",		-- 物品名:"铥矿奖章" 制造描述:"跟踪周围魔力水平的流动"
		},
		BISHOP_NIGHTMARE = "破烂的玩具",		-- 物品名:"损坏的发条主教"
		ROOK_NIGHTMARE = "仿生犀牛",		-- 物品名:"损坏的发条战车"
		KNIGHT_NIGHTMARE = "仿生马",		-- 物品名:"损坏的发条骑士"
		MINOTAUR = "它的弯钩好大！",		-- 物品名:"远古守护者"
		SPIDER_DROPPER = "跳起来就是一口，哎呦",		-- 物品名:"穴居悬蛛"
		NIGHTMARELIGHT = "一夜临安听春雨，携以情薄可欢愉",		-- 物品名:"梦魇灯座"  一夜临安听春雨，携以情薄可欢愉
		NIGHTSTICK = "电动的棒棒",		-- 物品名:"晨星锤" 制造描述:"用于夜间战斗的晨光"
		GREENGEM = "红色的宝石",		-- 物品名:"绿宝石"
		MULTITOOL_AXE_PICKAXE = "一把斧镐多种用处",		-- 物品名:"多用斧镐" 制造描述:"加倍实用"
		ORANGESTAFF = "空间的法则",		-- 物品名:"瞬移魔杖" 制造描述:"适合那些不喜欢走路的人"
		YELLOWAMULET = "可以照亮黑暗",		-- 物品名:"魔光护符" 制造描述:"从天堂汲取力量"
		GREENAMULET = "我十分需要这种东西",		-- 物品名:"建造护符" 制造描述:"用更少的材料合成物品！"
		SLURPERPELT = "扒了它的毛皮",			-- 物品名:"铥矿奖章"->啜食者皮 制造描述:"跟踪周围魔力水平的流动"
		SLURPER = "可爱捏，可以戴在头上！",		-- 物品名:"啜食者"
		SLURPER_PELT = "吃剩的啜食者",		-- 物品名:"啜食者皮"
		ARMORSLURPER = "戴上就不会饿饿了",		-- 物品名:"饥饿腰带" 制造描述:"保持肚子不饿"
		ORANGEAMULET = "适合不喜欢捡东西的人",		-- 物品名:"懒人护符" 制造描述:"适合那些不喜欢捡东西的人"
		YELLOWSTAFF = "可以召唤星星",		-- 物品名:"唤星者法杖" 制造描述:"召唤一个小星星"
		YELLOWGEM = "黄色的宝石",		-- 物品名:"黄宝石"
		ORANGEGEM = "橙色的宝石",		-- 物品名:"橙宝石"
        OPALSTAFF = "月亮帮我抵挡那黑暗吧",		-- 物品名:"唤月者魔杖"
        OPALPRECIOUSGEM = "有着七色光辉",		-- 物品名:"彩虹宝石"
        TELEBASE = 
		{
			VALID = "有宝石，偷偷拿走不会被人发现吧",		-- 物品名:"传送焦点"->有效 制造描述:"装上宝石试试"
			GEMS = "好穷",		-- 物品名:"传送焦点"->需要宝石 制造描述:"装上宝石试试"
		},
		GEMSOCKET = 
		{
			VALID = "有宝石，偷偷拿走不会被人发现吧",		-- 物品名:"宝石底座"->有效
			GEMS = "好穷",		-- 物品名:"宝石底座"->需要宝石
		},
		STAFFLIGHT = "烧烧的",		-- 物品名:"矮人之星"
        STAFFCOLDLIGHT = "凉凉的",		-- 物品名:"极光"
        ANCIENT_ALTAR = "砸掉有宝石哦~",		-- 物品名:"远古祭坛"
        ANCIENT_ALTAR_BROKEN = "砸掉有铥矿哦~",		-- 物品名:"损坏的远古祭坛"
        ANCIENT_STATUE = "雕塑着小虫子，踩踩踩",		-- 物品名:"远古雕像"
        LICHEN = "嘎嘣脆",		-- 物品名:"洞穴苔藓"
		CUTLICHEN = "好吃",		-- 物品名:"苔藓"
		CAVE_BANANA = "除了吃还可以用来玩的吧",		-- 物品名:"洞穴香蕉"
		CAVE_BANANA_COOKED = "这玩意烤了就玩不了了吧？",		-- 物品名:"烤香蕉"
		CAVE_BANANA_TREE = "banananananana！",		-- 物品名:"洞穴香蕉树"
		ROCKY = "硬硬的",		-- 物品名:"石虾"
		COMPASS =
		{
			GENERIC="天机司南！",		-- 物品名:"指南针"->默认 制造描述:"指向北方"
			N = "北",		-- 物品名:"指南针" 制造描述:"指向北方"
			S = "南",		-- 物品名:"指南针" 制造描述:"指向北方"
			E = "东",		-- 物品名:"指南针" 制造描述:"指向北方"
			W = "西",		-- 物品名:"指南针" 制造描述:"指向北方"
			NE = "东北",		-- 物品名:"指南针" 制造描述:"指向北方"
			SE = "东南",		-- 物品名:"指南针" 制造描述:"指向北方"
			NW = "西北",		-- 物品名:"指南针" 制造描述:"指向北方"
			SW = "西南",		-- 物品名:"指南针" 制造描述:"指向北方"
		},
        HOUNDSTOOTH = "磕到嘴了吧，让你整天狗叫！",		-- 物品名:"犬牙"
        ARMORSNURTLESHELL = "我是风铃我是龟！！",		-- 物品名:"蜗壳护甲"
        BAT = "蝙蝠有毒，头部以下应该也都能吃吧（嘟囔）",		-- 物品名:"洞穴蝙蝠"
        BATBAT = "难吃的东西做成武器",		-- 物品名:"蝙蝠棒" 制造描述:"所有科技都如此...耗费精神"
        BATWING = "全是骨头，不好吃",		-- 物品名:"洞穴蝙蝠翅膀"
        BATWING_COOKED = "烤了也不好吃~",		-- 物品名:"烤蝙蝠翅膀"
        BATCAVE = "应该不好吃吧？",		-- 物品名:"蝙蝠洞"
        BEDROLL_FURRY = "用吃剩的兔兔做的",		-- 物品名:"毛皮铺盖" 制造描述:"舒适地一觉睡到天亮！"
        BUNNYMAN = "小兔兔开开门",		-- 物品名:"兔人"
        FLOWER_CAVE = "亮眼的花",		-- 物品名:"荧光花"
        GUANO = "白色答辩",		-- 物品名:"鸟粪"
        LANTERN = "好亮亮！",		-- 物品名:"提灯" 制造描述:"可加燃料、明亮、便携！"
        LIGHTBULB = "好亮亮",		-- 物品名:"荧光果"
        MANRABBIT_TAIL = "兔兔的尾巴~",		-- 物品名:"兔绒"
        MUSHROOMHAT = "戴在头上就可以射孢子啦~",		-- 物品名:"蘑菇帽"
        MUSHROOM_LIGHT2 =
        {
            ON = "用蛙蛙做的灯",		-- 物品名:"炽菇灯"->开启 制造描述:"受到火山岩浆灯饰学问的激发"
            OFF = "放点燃料让蛙蛙亮起来！",		-- 物品名:"炽菇灯"->关闭 制造描述:"受到火山岩浆灯饰学问的激发"
            BURNT = "蛙蛙糊了！",		-- 物品名:"炽菇灯"->烧焦的 制造描述:"受到火山岩浆灯饰学问的激发"
        },
        MUSHROOM_LIGHT =
        {
            ON = "用蛙蛙做的灯",		-- 物品名:"蘑菇灯"->开启 制造描述:"任何蘑菇的完美添加物"
            OFF = "放点燃料让蛙蛙亮起来！",		-- 物品名:"蘑菇灯"->关闭 制造描述:"任何蘑菇的完美添加物"
            BURNT = "蛙蛙糊了！",		-- 物品名:"蘑菇灯"->烧焦的 制造描述:"任何蘑菇的完美添加物"
        },
        SLEEPBOMB = "蛙蛙的屎",		-- 物品名:"睡袋" 制造描述:"可以扔掉的袋子睡意沉沉"
        MUSHROOMBOMB = "蛙蛙的鼻屎",		-- 物品名:"炸弹蘑菇"
        SHROOM_SKIN = "蛙蛙的脚皮",		-- 物品名:"蘑菇皮"
        TOADSTOOL_CAP =
        {
            EMPTY = "蛙蛙！",		-- 物品名:"毒菌蟾蜍"
            INGROUND = "想坐上去",		-- 物品名:"毒菌蟾蜍"->在地里面
            GENERIC = "哇，好大的蛙蛙",		-- 物品名:"毒菌蟾蜍"->默认
        },
        TOADSTOOL =
        {
            GENERIC = "你这蛙蛙",		-- 物品名:"毒菌蟾蜍"->默认
            RAGE = "急了？",		-- 物品名:"毒菌蟾蜍"->愤怒
        },
        MUSHROOMSPROUT =
        {
            GENERIC = "烤一下会很香的吧！",		-- 物品名:"孢子帽"->默认
            BURNT = "有点烧",		-- 物品名:"孢子帽"->烧焦的
        },
        MUSHTREE_TALL =
        {
            GENERIC = "长长的蘑菇树？！",		-- 物品名:"蓝蘑菇树"->默认
            BLOOM = "它射了！",		-- 物品名:"蓝蘑菇树"->蘑菇树繁殖？？
        },
        MUSHTREE_MEDIUM =
        {
            GENERIC = "分叉的蘑菇树？！！",		-- 物品名:"红蘑菇树"->默认
            BLOOM = "它尿了一个孢子！",		-- 物品名:"红蘑菇树"->蘑菇树繁殖？？
        },
        MUSHTREE_SMALL =
        {
            GENERIC = "哥布林蘑菇树？！",		-- 物品名:"绿蘑菇树"->默认
            BLOOM = "哥布林得吃了！",		-- 物品名:"绿蘑菇树"->蘑菇树繁殖？？
        },
        MUSHTREE_TALL_WEBBED = "这颗蘑菇树被**了",		-- 物品名:"蛛网蓝蘑菇树"
        SPORE_TALL =
        {
            GENERIC = "长长的蘑菇射出来的",		-- 物品名:"蓝色孢子"->默认
            HELD = "我的，都是我的！",		-- 物品名:"蓝色孢子"->拿在手里
        },
        SPORE_MEDIUM =
        {
            GENERIC = "分叉的蘑菇射出来的",		-- 物品名:"红色孢子"->默认
            HELD = "我的，都是我的！",		-- 物品名:"红色孢子"->拿在手里
        },
        SPORE_SMALL =
        {
            GENERIC = "哥布林蘑菇射出来的",		-- 物品名:"绿色孢子"->默认
            HELD = "好想踩碎！",		-- 物品名:"绿色孢子"->拿在手里
        },
        RABBITHOUSE =
        {
            GENERIC = "小兔兔开一下门",		-- 物品名:"兔屋"->默认 制造描述:"可容纳一只巨大的兔子及其所有物品"
            BURNT = "兔兔好烧！",		-- 物品名:"兔屋"->烧焦的 制造描述:"可容纳一只巨大的兔子及其所有物品"
        },
        SLURTLE = "咬人的龟龟虫",		-- 物品名:"尖壳蜗牛"
        SLURTLE_SHELLPIECES = "碎掉惹！",		-- 物品名:"蜗壳碎片"
        SLURTLEHAT = "龟龟虫的壳壳！",		-- 物品名:"蜗牛帽"
        SLURTLEHOLE = "龟龟虫的粪堆！",		-- 物品名:"尖壳蜗牛窝"
        SLURTLESLIME = "我也有哦",		-- 物品名:"尖壳蜗牛黏液"
        SNURTLE = "风铃！",		-- 物品名:"圆壳蜗牛"
        SPIDER_HIDER = "龟龟蛛！",		-- 物品名:"洞穴蜘蛛"
        SPIDER_SPITTER = "喷喷蛛",		-- 物品名:"喷射蜘蛛"
        SPIDERHOLE = "龟龟蛛和喷喷蛛的家",		-- 物品名:"蛛网岩"
        SPIDERHOLE_ROCK = "里面有一只可爱的兔兔",		-- 物品名:"兔屋" 制造描述:"可容纳一只巨大的兔子及其所有物品"
        STALAGMITE = "挖挖挖！",		-- 物品名:"石笋"
        STALAGMITE_TALL = "挖挖挖",		-- 物品名:"石笋"
        TREASURECHEST_TRAP = "打开它不会伸出舌头吧？！",		-- 物品名:"宝箱"
        TURF_CARPETFLOOR = "闻起来有牛牛的味道",		-- 物品名:"地毯地板" 制造描述:"超级柔软气味像牦牛"
        TURF_CHECKERFLOOR = "天作棋盘星作子",		-- 物品名:"棋盘地板" 制造描述:"精心制作成棋盘状的大理石地砖"
        TURF_DIRT = "泥巴泥巴！",		-- 物品名:"泥土地皮"
        TURF_FOREST = "大树下面寸草不生",		-- 物品名:"森林地皮"
        TURF_GRASS = "长草了",		-- 物品名:"长草地皮"
        TURF_MARSH = "有触手可以玩哦",		-- 物品名:"沼泽地皮" 制造描述:"沼泽在哪，家就在哪！"
        TURF_METEOR = "好看哦",		-- 物品名:"月坑地皮" 制造描述:"月球表面的月坑"
        TURF_PEBBLEBEACH = "摔一跤会很痛吧",		-- 物品名:"岩石海滩地皮"
        TURF_ROAD = "跑快快！",		-- 物品名:"卵石路" 制造描述:"修建你自己的道路，通往任何地方"
        TURF_ROCKY = "膝盖会青的",		-- 物品名:"岩石地皮"
        TURF_SAVANNA = "草草的",		-- 物品名:"热带草原地皮"
        TURF_WOODFLOOR = "树合成的地板",		-- 物品名:"木地板" 制造描述:"优质复合地板"
		TURF_CAVE="答辩铺地板",		-- 物品名:"鸟粪地皮"
		TURF_FUNGUS="长蘑菇的屑",		-- 物品名:"菌类地皮"
		TURF_SINKHOLE="在这里一定很舒服吧",		-- 物品名:"黏滑地皮"
		TURF_UNDERROCK="好硬硬！",		-- 物品名:"洞穴岩石地皮"
		TURF_MUD="尿尿和泥泥！",		-- 物品名:"泥泞地皮"
		TURF_DECIDUOUS = "小非猪的地皮",		-- 物品名:"桦树地皮"
		TURF_SANDY = "这里面一定有兔兔",		-- 物品名:"兔屋" 制造描述:"可容纳一只巨大的兔子及其所有物品"
		TURF_BADLANDS = "兔兔的窝窝",		-- 物品名:"兔屋" 制造描述:"可容纳一只巨大的兔子及其所有物品"
		TURF_DESERTDIRT = "沙雕地皮",		-- 物品名:"沙漠地皮"
		TURF_FUNGUS_GREEN = "哥布林掉色了吗？",		-- 物品名:"菌类地皮"
		TURF_FUNGUS_RED = "分叉蘑菇的屑",		-- 物品名:"菌类地皮"
		TURF_DRAGONFLY = "火红色的地板，可以火灾蔓延速度",		-- 物品名:"鳞状地板" 制造描述:"消除火灾蔓延速度"
		POWCAKE = "狗都不吃",		-- 物品名:"芝士蛋糕"
        CAVE_ENTRANCE = "用火药炸开！",		-- 物品名:"堵住的陷洞"
        CAVE_ENTRANCE_RUINS = "下面那有什么？",		-- 物品名:"被堵住的陷洞"->单机 洞二入口
       	CAVE_ENTRANCE_OPEN = 
        {
            GENERIC = "钻洞洞！",		-- 物品名:"陷洞"->默认
            OPEN = "钻进去看看！",		-- 物品名:"陷洞"->打开
            FULL = "让我进去！",		-- 物品名:"陷洞"->满了
        },
        CAVE_EXIT = 
        {
            GENERIC = "有点喜欢这下面呢",		-- 物品名:"楼梯"->默认
            OPEN = "想出去了",		-- 物品名:"楼梯"->打开
            FULL = "让我出去！",		-- 物品名:"楼梯"->满了
        },
		MAXWELLPHONOGRAPH = "里面传出音乐来！",		-- 物品名:"麦斯威尔的留声机"->单机 麦斯威尔留声机
		BOOMERANG = "这东西能打死人？",		-- 物品名:"回旋镖" 制造描述:"来自澳洲土著"
		PIGGUARD = "打人知非！",		-- 物品名:"猪人守卫"
		ABIGAIL =
		{
            LEVEL1 =
            {
                "你……是真人吗？",		-- 物品名:未找到 制造描述:未找到
                "你……是真人吗？",		-- 物品名:未找到 制造描述:未找到
            },
            LEVEL2 = 
            {
                "你……是真人吗？",		-- 物品名:未找到 制造描述:未找到
                "你……是真人吗？",		-- 物品名:未找到 制造描述:未找到
            },
            LEVEL3 = 
            {
                "你……是真人吗？",		-- 物品名:未找到 制造描述:未找到
                "你……是真人吗？",		-- 物品名:未找到 制造描述:未找到
            },
		},
		ADVENTURE_PORTAL = "这个会去哪？",		-- 物品名:"麦斯威尔之门"->单机 麦斯威尔之门
		AMULET = "可以让我重生",		-- 物品名:"重生护符" 制造描述:"逃离死神的魔爪"
		ANIMAL_TRACK = "抓象象",		-- 物品名:"动物足迹"
		ARMORGRASS = "性感的草裙",		-- 物品名:"草甲" 制造描述:"提供少许防护"
		ARMORMARBLE = "穿上它我就是战神",		-- 物品名:"大理石甲" 制造描述:"它很重，但能够保护你"
		ARMORWOOD = "我无敌了！",		-- 物品名:"木甲" 制造描述:"为你抵御部分伤害"
		ARMOR_SANITY = "感觉穿上会有点烧",		-- 物品名:"魂甲" 制造描述:"保护你的躯体，但无法保护你的心智"
		ASH =
		{
			GENERIC = "把你给扬了！",		-- 物品名:"灰烬"->默认
			REMAINS_GLOMMERFLOWER = "嗷……全没了",		-- 物品名:"灰烬"->单机专用
			REMAINS_EYE_BONE = "再见咯，闪光棒",		-- 物品名:"灰烬"->单机专用
			REMAINS_THINGIE = "没有了",		-- 物品名:"灰烬"->单机专用
		},
		AXE = "看斧",		-- 物品名:"斧头" 制造描述:"砍倒树木！"
		BABYBEEFALO = 
		{
			GENERIC = "可可爱爱",		-- 物品名:"小牦牛"->默认
		    SLEEPING = "它暂时死了",		-- 物品名:"小牦牛"->睡着了
        },
        BUNDLE = "放水里可以浮起来！",		-- 物品名:"捆绑物资"
        BUNDLEWRAP = "有点用，但不多",		-- 物品名:"捆绑包装" 制造描述:"打包你的东西的部分和袋子"
		BACKPACK = "背上背包,出发吧",		-- 物品名:"背包" 制造描述:"携带更多物品"
		BACONEGGS = "从前有一头叫培根的猪人",		-- 物品名:"培根煎蛋"
		BANDAGE = "治愈身体",		-- 物品名:"蜂蜜药膏" 制造描述:"愈合小伤口"
		BASALT = "这也太硬了吧",		-- 物品名:"玄武岩"
		BEARDHAIR = "卷曲的毛发",		-- 物品名:"胡子"
		BEARGER = "急了，急了！",		-- 物品名:"狂暴熊獾"
		BEARGERVEST = "用吃剩的熊熊做的衣服",		-- 物品名:"熊皮背心" 制造描述:"熊皮背心"
		ICEPACK = "用吃剩的熊熊做的包包",		-- 物品名:"保鲜背包" 制造描述:"容量虽小，但能保持东西新鲜"
		BEARGER_FUR = "用来包住熊熊的肉肉和骨头",		-- 物品名:"熊皮" 制造描述:"毛皮再生"
		BEDROLL_STRAW = "睡着很不舒服",		-- 物品名:"草席卷" 制造描述:"一觉睡到天亮"
		BEEQUEEN = "这也太能生了吧",		-- 物品名:"蜂王"
		BEEQUEENHIVE = 
		{
			GENERIC = "黏黏的",		-- 物品名:"蜂蜜地块"->默认
			GROWING = "有点小哦……",		-- 物品名:"蜂蜜地块"->正在生长
		},
        BEEQUEENHIVEGROWN = "有个洞洞？",		-- 物品名:"巨大蜂巢"
        BEEGUARD = "小蜜蜂，送死死……",		-- 物品名:"嗡嗡蜜蜂"
        HIVEHAT = "姐就是女王，自信放光芒！！！",		-- 物品名:"蜂王帽"
        MINISIGN =
        {
            GENERIC = "记录着我所看见的东西",		-- 物品名:"小木牌"->默认
            UNDRAWN = "还没有记录下来",		-- 物品名:"小木牌"->没有画画
        },
        MINISIGN_ITEM = "我应该把它插在某些物品前方",		-- 物品名:"小木牌" 制造描述:"用羽毛笔在这些上面画画"
		BEE =
		{
			GENERIC = "趁它不注意偷点蜂蜜吧",		-- 物品名:"蜜蜂"->默认
			HELD = "挤点蜂蜜吃",		-- 物品名:"蜜蜂"->拿在手里
		},
		BEEBOX =
		{
			READY = "蜂蜂的公寓",		-- 物品名:"蜂箱"->准备好的 满的 制造描述:"贮存你自己的蜜蜂"
			FULLHONEY = "该收房租了",		-- 物品名:"蜂箱"->蜂蜜满了 制造描述:"贮存你自己的蜜蜂"
			GENERIC = "蜂蜂的公寓",		-- 物品名:"蜂箱"->默认 制造描述:"贮存你自己的蜜蜂"
			NOHONEY = "加油打工付我房租！",		-- 物品名:"蜂箱"->没有蜂蜜 制造描述:"贮存你自己的蜜蜂"
			SOMEHONEY = "这点可不够哦",		-- 物品名:"蜂箱"->有一些蜂蜜 制造描述:"贮存你自己的蜜蜂"
			BURNT = "我的蜂蜂园区烧掉惹！",		-- 物品名:"蜂箱"->烧焦的 制造描述:"贮存你自己的蜜蜂"
		},
		MUSHROOM_FARM =
		{
			STUFFED = "好多蘑菇了",		-- 物品名:"蘑菇农场"->塞，满了？？ 制造描述:"种蘑菇"
			LOTS = "长蘑菇了！",		-- 物品名:"蘑菇农场"->很多 制造描述:"种蘑菇"
			SOME = "开始生长吧",		-- 物品名:"蘑菇农场"->有一些 制造描述:"种蘑菇"
			EMPTY = "种些蘑菇试试",		-- 物品名:"蘑菇农场" 制造描述:"种蘑菇"
			ROTTEN = "需要更多的怪木头！",		-- 物品名:"蘑菇农场"->腐烂的--需要活木 制造描述:"种蘑菇"
			BURNT = "烤蘑菇怎么种下去啊，魂淡",		-- 物品名:"蘑菇农场"->烧焦的 制造描述:"种蘑菇"
			SNOWCOVERED = "它们也在冬眠",		-- 物品名:"蘑菇农场"->被雪覆盖 制造描述:"种蘑菇"
		},
		BEEFALO =
		{
			FOLLOWER = "给我骑骑！",		-- 物品名:"牦牛"->追随者
			GENERIC = "牛牛的毛毛好多多！",		-- 物品名:"牦牛"->默认
			NAKED = "牛牛秃了！",		-- 物品名:"牦牛"->牛毛被刮干净了
			SLEEPING = "牛牛暂时死了",		-- 物品名:"牦牛"->睡着了
            DOMESTICATED = "平平无奇的牛牛",		-- 物品名:"牦牛"->驯化牛
            ORNERY = "好顶的牛牛！",		-- 物品名:"牦牛"->战斗牛
            RIDER = "好快的牛牛！",		-- 物品名:"牦牛"->骑行牛
            PUDGY = "好粗的牛牛！",		-- 物品名:"牦牛"->胖牛
		},
		BEEFALOHAT = "吃剩的牛牛做的帽子。",		-- 物品名:"牛角帽" 制造描述:"成为牛群中的一员！连气味也变得一样"
		BEEFALOWOOL = "牛牛的毛毛",		-- 物品名:"牛毛"
		BEEHAT = "辣么粗的针扎我都没有感觉了！",		-- 物品名:"养蜂帽" 制造描述:"防止被愤怒的蜜蜂蜇伤"
        BEESWAX = "可以做蜡烛嘛？",		-- 物品名:"蜂蜡" 制造描述:"一种有用的防腐蜂蜡"
		BEEHIVE = "嗡嗡嗡！",		-- 物品名:"野生蜂窝"
		BEEMINE = "里面有蜂蜂",		-- 物品名:"蜜蜂地雷" 制造描述:"变成武器的蜜蜂会出什么问题？"
		BEEMINE_MAXWELL = "不喜欢它嗡嗡叫",		-- 物品名:"麦斯威尔的蚊子陷阱"->单机 麦斯威尔的蚊子陷阱
		BERRIES = "好甜甜！",		-- 物品名:"浆果"
		BERRIES_COOKED = "烤熟的甜甜",		-- 物品名:"烤浆果"
        BERRIES_JUICY = "好多水水！",		-- 物品名:"多汁浆果"
        BERRIES_JUICY_COOKED = "爆汁汁！",		-- 物品名:"烤多汁浆果"
		BERRYBUSH =
		{
			BARREN = "它饿饿要赤石",		-- 物品名:"浆果丛"
			WITHERED = "它干巴了",		-- 物品名:"浆果丛"->枯萎了
			GENERIC = "摘下来做樱花果冻！",		-- 物品名:"浆果丛"->默认
			PICKED = "采光了！",		-- 物品名:"浆果丛"->被采完了
			DISEASED = "生病就要去看医生，来看我也可以",		-- 物品名:"浆果丛"->生病了
			DISEASING = "看着不太对",		-- 物品名:"浆果丛"->正在生病？？
			BURNING = "哦不，我的樱花果冻！",		-- 物品名:"浆果丛"->正在燃烧
		},
		BERRYBUSH_JUICY =
		{
			BARREN = "它饿饿要赤石",		-- 物品名:"多汁浆果丛"
			WITHERED = "它干巴了",		-- 物品名:"多汁浆果丛"->枯萎了
			GENERIC = "看着就好吃",		-- 物品名:"多汁浆果丛"->默认
			PICKED = "采光了！",		-- 物品名:"多汁浆果丛"->被采完了
			DISEASED = "看起来不太好",		-- 物品名:"多汁浆果丛"->生病了
			DISEASING = "看着不太对",		-- 物品名:"多汁浆果丛"->正在生病？？
			BURNING = "会爆汁嘛？",		-- 物品名:"多汁浆果丛"->正在燃烧
		},
		BIGFOOT = "玉！",		-- 物品名:"大脚怪"->单机 大脚怪
		BIRDCAGE =
		{
			GENERIC = "鸟儿的家",		-- 物品名:"鸟笼"->默认 制造描述:"为你的鸟类朋友提供一个幸福的家"
			OCCUPIED = "它好像想吃怪物肉了",		-- 物品名:"鸟笼"->被占领 制造描述:"为你的鸟类朋友提供一个幸福的家"
			SLEEPING = "它好像似了",		-- 物品名:"鸟笼"->睡着了 制造描述:"为你的鸟类朋友提供一个幸福的家"
			HUNGRY = "鸟儿饿饿~",		-- 物品名:"鸟笼"->有点饿了 制造描述:"为你的鸟类朋友提供一个幸福的家"
			STARVING = "鸟儿要饿死辣！",		-- 物品名:"鸟笼"->挨饿 制造描述:"为你的鸟类朋友提供一个幸福的家"
			DEAD = "饿成小肉辣！！",		-- 物品名:"鸟笼"->死了 制造描述:"为你的鸟类朋友提供一个幸福的家"
			SKELETON = "……",		-- 物品名:"骷髅"
		},
		BIRDTRAP = "抓小鸟",		-- 物品名:"捕鸟陷阱" 制造描述:"捕捉会飞的动物"
		CAVE_BANANA_BURNT = "毁掉了",		-- 物品名:"鸟笼"->烧焦的洞穴香蕉树 制造描述:"为你的鸟类朋友提供一个幸福的家"
		BIRD_EGG = "看着就很香",		-- 物品名:"鸟蛋"
		BIRD_EGG_COOKED = "熟食，好吃",		-- 物品名:"煎蛋"
		BISHOP = "差点被它一眼瞪死！",		-- 物品名:"发条主教"
		BLOWDART_FIRE = "还不如火把",		-- 物品名:"火焰吹箭" 制造描述:"向你的敌人喷火"
		BLOWDART_SLEEP = "好机会！",		-- 物品名:"催眠吹箭" 制造描述:"催眠你的敌人"
		BLOWDART_PIPE = "瞄准！",		-- 物品名:"吹箭" 制造描述:"向你的敌人喷射利齿"
		BLOWDART_YELLOW = "电光四射",		-- 物品名:"雷电吹箭" 制造描述:"朝你的敌人放闪电"
		BLUEAMULET = "放在身上好凉凉!",		-- 物品名:"寒冰护符" 制造描述:"多么冰冷酷炫的护符"
		BLUEGEM = "蓝色的宝石",		-- 物品名:"蓝宝石"
		BLUEPRINT = 
		{ 
            COMMON = "复杂的纹路",		-- 物品名:"蓝图"
            RARE = "稀有的图纸",		-- 物品名:"蓝图"->罕见的
        },
        SKETCH = "骨头架！",		-- 物品名:"{item}骨架"
		BLUE_CAP = "采摘的蓝伞伞！",		-- 物品名:"采摘的蓝蘑菇"
		BLUE_CAP_COOKED = "烤熟的蓝伞伞！",		-- 物品名:"烤蓝蘑菇"
		BLUE_MUSHROOM =
		{
			GENERIC = "小小的蓝伞伞",		-- 物品名:"蓝蘑菇"->默认
			INGROUND = "萎了",		-- 物品名:"蓝蘑菇"->在地里面
			PICKED = "被拔掉惹",		-- 物品名:"蓝蘑菇"->被采完了
		},
		BOARDS = "树树做的材料",		-- 物品名:"木板" 制造描述:"更平直的木头"
		BONESHARD = "好友碎片",		-- 物品名:"骨头碎片"
		BONESTEW = "吨吨吨",		-- 物品名:"炖肉汤"
		BUGNET = "派大星，我们一起去抓水母吧！",		-- 物品名:"捕虫网" 制造描述:"抓虫子用的"
		BUSHHAT = "我会永远视奸你，永远永远！",		-- 物品名:"灌木丛帽" 制造描述:"很好的伪装！"
		BUTTER = "味道不错",		-- 物品名:"黄油"
		BUTTERFLY =
		{
			GENERIC = "好吃的！",		-- 物品名:"蝴蝶"->默认
			HELD = "科技与狠活的原料",		-- 物品名:"蝴蝶"->拿在手里
		},
		BUTTERFLYMUFFIN = "黑暗料理！",		-- 物品名:"蝴蝶松饼"
		BUTTERFLYWINGS = "科技与狠活，出来吧我的烤箱！",		-- 物品名:"蝴蝶翅膀"
		BUZZARD = "呔，秃驴",		-- 物品名:"秃鹫"
		SHADOWDIGGER = "撕开就可以做饭饭了！",		-- 物品名:"蝴蝶"
		CACTUS = 
		{
			GENERIC = "会扎手手的吧？",		-- 物品名:"仙人掌"->默认
			PICKED = "我当时一把就薅下来了",		-- 物品名:"仙人掌"->被采完了
		},
		CACTUS_MEAT_COOKED = "刺都烤的脆脆的！",		-- 物品名:"烤仙人掌肉"
		CACTUS_MEAT = "这我都不用嚼",		-- 物品名:"仙人掌肉"
		CACTUS_FLOWER = "羊羊就吃这个嘛？",		-- 物品名:"仙人掌花"
		COLDFIRE =
		{
			EMBERS = "火要燃尽了",		-- 物品名:"冰火"->即将熄灭 制造描述:"这火是越烤越冷的冰火"
			GENERIC = "这难道就是传说中的乾蓝冰焰？",		-- 物品名:"冰火"->默认 制造描述:"这火是越烤越冷的冰火"
			HIGH = "这难道就是传说中的骨灵冷火？",		-- 物品名:"冰火"->高 制造描述:"这火是越烤越冷的冰火"
			LOW = "有点小了",		-- 物品名:"冰火"->低？ 制造描述:"这火是越烤越冷的冰火"
			NORMAL = "很凉快",		-- 物品名:"冰火"->普通 制造描述:"这火是越烤越冷的冰火"
			OUT = "燃尽了",		-- 物品名:"冰火"->出去？外面？ 制造描述:"这火是越烤越冷的冰火"
		},
		CAMPFIRE =
		{
			EMBERS = "火要熄灭了",		-- 物品名:"营火"->即将熄灭 制造描述:"燃烧时发出光亮"
			GENERIC = "燃烧的烈火",		-- 物品名:"营火"->默认 制造描述:"燃烧时发出光亮"
			HIGH = "谢谢大火",		-- 物品名:"营火"->高 制造描述:"燃烧时发出光亮"
			LOW = "火变小了",		-- 物品名:"营火"->低？ 制造描述:"燃烧时发出光亮"
			NORMAL = "温暖舒适",		-- 物品名:"营火"->普通 制造描述:"燃烧时发出光亮"
			OUT = "再见了",		-- 物品名:"营火"->出去？外面？ 制造描述:"燃烧时发出光亮"
		},
		CANE = "路边的老登最喜欢用了",		-- 物品名:"拐棍" 制造描述:"泰然自若地快步走"
		CATCOON = "圣火昭昭，圣火曜曜，凡我弟子，喵喵喵喵！",		-- 物品名:"浣熊猫"
		CATCOONDEN = 
		{
			GENERIC = "喵喵教会！",		-- 物品名:"空心树桩"->默认
			EMPTY = "喵喵喵喵！",		-- 物品名:"空心树桩"
		},
		CATCOONHAT = "喵喵教主做的帽子",		-- 物品名:"浣熊猫帽子" 制造描述:"适合那些重视温暖甚于朋友的人"
		COONTAIL = "吃剩的喵喵教主",		-- 物品名:"浣熊猫尾巴"
		CARROT = "兔子先生很爱吃",		-- 物品名:"胡萝卜"
		CARROT_COOKED = "那很会吃了！",		-- 物品名:"烤胡萝卜"
		CARROT_PLANTED = "兔子先生留给我的！",		-- 物品名:"胡萝卜"
		CARROT_SEEDS = "兔子先生的答辩里翻出来的！",		-- 物品名:"胡萝卜种子"
		CARTOGRAPHYDESK =
		{
			GENERIC = "没苦硬吃的起点",		-- 物品名:"制图桌"->默认 制造描述:"准确地告诉别人你去过哪里"
			BURNING = "烧掉了",		-- 物品名:"制图桌"->正在燃烧 制造描述:"准确地告诉别人你去过哪里"
			BURNT = "没了",		-- 物品名:"制图桌"->烧焦的熊獾 制造描述:"准确地告诉别人你去过哪里"
		},
		WATERMELON_SEEDS = "种西瓜嘛？",		-- 物品名:"西瓜种子"
		
		CAVE_FERN = "看起来不太好吃",		-- 物品名:"蕨类植物"
		CHARCOAL = "它糊了",		-- 物品名:"木炭"
        CHESSPIECE_PAWN = "我超，冰！",		-- 物品名:"卒子棋子"
        CHESSPIECE_ROOK =
        {
            GENERIC = "仿生犀牛咬咬咬！",		-- 物品名:"战车棋子"->默认
            STRUGGLE = "它在震动耶？！",		-- 物品名:"战车棋子"->三基佬棋子晃动
        },
        CHESSPIECE_KNIGHT =
        {
            GENERIC = "仿生马儿顶顶顶！",		-- 物品名:"骑士棋子"->默认
            STRUGGLE = "它在震动耶？！",		-- 物品名:"骑士棋子"->三基佬棋子晃动
        },
        CHESSPIECE_BISHOP =
        {
            GENERIC = "不会被瞪死吧？！",		-- 物品名:"主教棋子"->默认
            STRUGGLE = "它在震动耶？！",		-- 物品名:"主教棋子"->三基佬棋子晃动
        },
        CHESSPIECE_MUSE = " 你真没见过黑社会啊？",		-- 物品名:"女王棋子"
        CHESSPIECE_FORMAL = "黑手！",		-- 物品名:"国王棋子"
        CHESSPIECE_HORNUCOPIA = "奇怪的雕刻",		-- 物品名:"丰饶角雕刻"
        CHESSPIECE_PIPE = "你脸红个泡泡茶壶",		-- 物品名:"泡泡烟斗雕塑"
        CHESSPIECE_DEERCLOPS = "眼球主人的雕像",		-- 物品名:"独眼巨鹿棋子"
        CHESSPIECE_BEARGER = "看起来有点急",		-- 物品名:"棋子"
        CHESSPIECE_MOOSEGOOSE =
        {
            "鸭鸭雕像！",		-- 物品名:"驼鹿棋子" 制造描述:未找到
        },
        CHESSPIECE_DRAGONFLY = "瞪大双眼睛吧",		-- 物品名:"龙蝇棋子"
        CHESSPIECE_BUTTERFLY = "好丑",		-- 物品名:"月蛾棋子"
        CHESSPIECE_ANCHOR = "锚儿小雕？",		-- 物品名:"锚棋子"
        CHESSPIECE_MOON = "看起来就不好用！",		-- 物品名:"\\“月亮\\” 棋子"
        CHESSPIECE_CARRAT = "看起来很好吃",		-- 物品名:"胡萝卜鼠雕像"
        CHESSJUNK1 = "我就是破烂王！",		-- 物品名:"损坏的发条装置"
        CHESSJUNK2 = "我的！都是我的！",		-- 物品名:"损坏的发条装置"
        CHESSJUNK3 = "最喜欢捡破烂了！",		-- 物品名:"损坏的发条装置"
		CHESTER = "眼骨是插在哪里的呢？",		-- 物品名:"切斯特"
		CHESTER_EYEBONE =
		{
			GENERIC = "真空被发现了？！",		-- 物品名:"眼骨"->默认
			WAITING = "好像似了",		-- 物品名:"眼骨"->需要等待
		},
		COOKEDMANDRAKE = "你接着叫啊？",		-- 物品名:"烤曼德拉草"
		COOKEDMEAT = "吃肉肉",		-- 物品名:"烤大肉"
		COOKEDMONSTERMEAT = "这东西会硌牙的吧",		-- 物品名:"烤怪物肉"
		COOKEDSMALLMEAT = "塞牙牙",		-- 物品名:"烤小肉"
		COOKPOT =
		{
			COOKING_LONG = "好饿饿",		-- 物品名:"烹饪锅"->饭还需要很久 制造描述:"制作更好的食物"
			COOKING_SHORT = "好急急",		-- 物品名:"烹饪锅"->饭快做好了 制造描述:"制作更好的食物"
			DONE = "饭饭！",		-- 物品名:"烹饪锅"->完成了 制造描述:"制作更好的食物"
			EMPTY = "希望里面有饭饭",		-- 物品名:"烹饪锅" 制造描述:"制作更好的食物"
			BURNT = "糊了……",		-- 物品名:"烹饪锅"->烧焦的 制造描述:"制作更好的食物"
		},
		CORN = "好吃呢",		-- 物品名:"玉米"
		CORN_COOKED = "爆开了！",		-- 物品名:"爆米花"
		CORN_SEEDS = "可以种出更多玉米！",		-- 物品名:"玉米种子"
        CANARY =
		{
			GENERIC = "想要小偷包包~",		-- 物品名:"金丝雀"->默认
			HELD = "芜湖~！？",		-- 物品名:"金丝雀"->拿在手里
		},
        CANARY_POISONED = "好耶，可以和蛙蛙一起做睡袋了！",		-- 物品名:"金丝雀（有翅膀的动物）"
		CRITTERLAB = "看看小穴",		-- 物品名:"岩石巢穴"
        CRITTER_GLOMLING = "宠物非非",		-- 物品名:"小罗姆"
        CRITTER_DRAGONLING = "快去送！",		-- 物品名:"蜂群卫士"
		CRITTER_LAMB = "Q弹！",		-- 物品名:"小钢羊"
        CRITTER_PUPPY = "应该不会拆家的吧？",		-- 物品名:"小座狼"
        CRITTER_KITTEN = "小咪咪~",		-- 物品名:"小浣猫"
        CRITTER_PERDLING = "小鸡鸡！",		-- 物品名:"小火鸡"
		CRITTER_LUNARMOTHLING = "双皮奶宠物",		-- 物品名:"小蛾子"
		CROW =
		{
			GENERIC = "黑色的鸟鸟！",		-- 物品名:"乌鸦"->默认
			HELD = "好黑好黑",		-- 物品名:"乌鸦"->拿在手里
		},
		CUTGRASS = "草，一种植物",		-- 物品名:"草"
		CUTREEDS = "坚韧的草",		-- 物品名:"采下的芦苇"
		CUTSTONE = "豆腐！一头撞死，还是算了",		-- 物品名:"石砖" 制造描述:"切成正方形的石头"
		DEADLYFEAST = "不应该吃那个",		-- 物品名:"致命的盛宴"->致命盛宴 单机
		DEER =
		{
			GENERIC = "听说打狍子一下，会回来看是谁打的",		-- 物品名:"无眼鹿"->默认
			ANTLER = "傻狍子长角了！",		-- 物品名:"无眼鹿"
		},
        DEER_ANTLER = "狍子的角！！",		-- 物品名:"鹿角"
        DEER_GEMMED = "宝石狍子！",		-- 物品名:"无眼鹿"
		DEERCLOPS = "鹿先生，你那个圆圆的东西可以借给我嘛？",		-- 物品名:"独眼巨鹿"
		DEERCLOPS_EYEBALL = "他借给我了",		-- 物品名:"独眼巨鹿眼球"
		EYEBRELLAHAT =	"鹿先生为我做的帽子",		-- 物品名:"眼球伞" 制造描述:"面向天空的眼球让你保持干燥"
		DEPLETED_GRASS =
		{
			GENERIC = "早，秃了",		-- 物品名:"草"->默认
		},
        GOGGLESHAT = "吃剩的猪猪做的眼镜",		-- 物品名:"时髦的护目镜" 制造描述:"你可以瞪大眼睛看装饰性护目镜"
        DESERTHAT = "两只猪猪",		-- 物品名:"沙漠护目镜" 制造描述:"从你的眼睛里把沙子揉出来"
		DEVTOOL = "喜欢这个！",		-- 物品名:"开发工具"
		DEVTOOL_NODEV = "做不了",		-- 物品名:"草"
		DIRTPILE = "有肉吗？",		-- 物品名:"可疑的土堆"
		DIVININGROD =
		{
			COLD = "好冷",		-- 物品名:"冻伤"->冷了
			GENERIC = "上面这个奇怪的盒子是什么？",		-- 物品名:"探测杖"->默认 制造描述:"肯定有方法可以离开这里..."
			HOT = "它在向我喊叫！！",		-- 物品名:"中暑"->热了
			WARM = "声音越来越大了",		-- 物品名:"探测杖"->温暖 制造描述:"肯定有方法可以离开这里..."
			WARMER = "更大声了！",		-- 物品名:"探测杖" 制造描述:"肯定有方法可以离开这里..."
		},
		DIVININGRODBASE =
		{
			GENERIC = "这是什么？",		-- 物品名:"探测杖底座"->默认
			READY = "还缺点东西……",		-- 物品名:"探测杖底座"->准备好的 满的
			UNLOCKED = "我想这个现在可以用了！",		-- 物品名:"探测杖底座"->解锁了
		},
		DIVININGRODSTART = "这东西看起来很奇怪",		-- 物品名:"探测杖底座"->单机探测杖底座
		DRAGONFLY = "小苍蝇，一拖鞋拍死",		-- 物品名:"龙蝇"
		ARMORDRAGONFLY = "拍碎的苍蝇做的盔甲！！",		-- 物品名:"鳞甲" 制造描述:"脾气火爆的盔甲"
		DRAGON_SCALES = "苍蝇碎片……",		-- 物品名:"鳞片"
		DRAGONFLYCHEST = "苍蝇箱子",		-- 物品名:"巨鳞宝箱" 制造描述:"一种结实且防火的容器"
		DRAGONFLYFURNACE = 
		{
			HAMMERED = "被弄坏了",		-- 物品名:"龙鳞火炉"->被锤了 制造描述:"给自己建造一个苍蝇暖炉"
			GENERIC = "在它旁边睡觉一定很暖和", --no gems		-- 物品名:"龙鳞火炉"->默认 制造描述:"给自己建造一个苍蝇暖炉"
			NORMAL = "很暖和", --one gem		-- 物品名:"龙鳞火炉"->普通 制造描述:"给自己建造一个苍蝇暖炉"
			HIGH = "好烫！", --two gems		-- 物品名:"龙鳞火炉"->高 制造描述:"给自己建造一个苍蝇暖炉"
		},
        HUTCH = "破隐就靠你了！！",		-- 物品名:"哈奇"
        HUTCH_FISHBOWL =
        {
		    GENERIC = "小鱼鱼！",		-- 物品名:"星空"->默认
            GENERIC = "翻肚皮了",		-- 物品名:"星空"->需要等待
        },
		LAVASPIT = 
		{
			HOT = "变烫的石头！",		-- 物品名:"中暑"->热了
			COOL = "现在变成石头了",		-- 物品名:"龙蝇唾液"
		},
		LAVA_POND = "多喝热水",		-- 物品名:"岩浆池"
		LAVAE = "烧虫虫！",		-- 物品名:"岩浆虫"
		LAVAE_COCOON = "凉了",		-- 物品名:"冷冻虫卵"
		LAVAE_PET = 
		{
			STARVING = "它要烧家了！",		-- 物品名:"超级可爱岩浆虫"->挨饿
			HUNGRY = "吃灰吧你！",		-- 物品名:"超级可爱岩浆虫"->有点饿了
			CONTENT = "它看起来很开心！",		-- 物品名:"超级可爱岩浆虫"->内容？？？、
			GENERIC = "它的拥抱很温暖",		-- 物品名:"超级可爱岩浆虫"->默认
		},
		LAVAE_EGG = 
		{
			GENERIC = "是不是猪，反应这么慢",		-- 物品名:"岩浆虫卵"->默认
		},
		LAVAE_EGG_CRACKED =
		{
			COLD = "感觉不如石果",		-- 物品名:"冻伤"->冷了
			COMFY = "扭的好烧！",		-- 物品名:"岩浆虫卵"->舒服的
		},
		LAVAE_TOOTH = "小牙尖尖",		-- 物品名:"岩浆虫尖牙"
		DRAGONFRUIT = "好甜！！",		-- 物品名:"火龙果"
		DRAGONFRUIT_COOKED = "尝一下吧。。。。不好吃",		-- 物品名:"烤火龙果"
		DRAGONFRUIT_SEEDS = "水果籽",		-- 物品名:"火龙果种子"
		DRAGONPIE = "这是最好的牛饲料！！",		-- 物品名:"火龙果派"
		DRUMSTICK = "小黑子的鸡脚！",		-- 物品名:"鸟腿"
		DRUMSTICK_COOKED = "好香香！",		-- 物品名:"炸鸟腿"
		DUG_BERRYBUSH = "果冻！果冻！",		-- 物品名:"浆果丛"
		DUG_BERRYBUSH_JUICY = "跟我来吧我带你回家",		-- 物品名:"多汁浆果丛"
		DUG_GRASS = "这是一种植物",		-- 物品名:"草丛"
		DUG_MARSH_BUSH = "扎手手！",		-- 物品名:"尖刺灌木"
		DUG_SAPLING = "会给你找个好地方种下",		-- 物品名:"树苗"
		DURIAN = "好臭！我好喜欢！",		-- 物品名:"榴莲"
		DURIAN_COOKED = "偷偷吃屎不会有人发现吧？！",		-- 物品名:"超臭榴莲"
		DURIAN_SEEDS = "臭臭的，应该可以种出大便！",		-- 物品名:"榴莲种子"
		EARMUFFSHAT = "兔兔送我的冬季礼物！",		-- 物品名:"兔耳罩" 制造描述:"毛茸茸的保暖物品"
		EGGPLANT = "紫色心情！",		-- 物品名:"茄子"
		EGGPLANT_COOKED = "加点蒜蓉就更好了",		-- 物品名:"烤茄子"
		EGGPLANT_SEEDS = "种出更多的紫色心情！",		-- 物品名:"茄子种子"
		ENDTABLE = 
		{
			BURNT = "我的茶几！",		-- 物品名:"茶几"->烧焦的 制造描述:"一张装饰桌"
			GENERIC = "种点花吧！",		-- 物品名:"茶几"->默认 制造描述:"一张装饰桌"
			EMPTY = "家总是需要装饰的",		-- 物品名:"茶几" 制造描述:"一张装饰桌"
			WILTED = "花有重开日？换个新的吧！",		-- 物品名:"茶几"->枯萎的 制造描述:"一张装饰桌"
			FRESHLIGHT = "照亮我可爱的脸",		-- 物品名:"茶几"->茶几-新的发光的 制造描述:"一张装饰桌"
			OLDLIGHT = "燃尽了嘛", -- will be wilted soon, light radius will be very small at this point		-- 物品名:"茶几"->茶几-旧的发光的 制造描述:"一张装饰桌"
		},
		DECIDUOUSTREE = 
		{
			BURNING = "在做好吃的耶",		-- 物品名:"桦树"->正在燃烧
			BURNT = "快找找有没有烤熟的桦栗果",		-- 物品名:"桦树"->烧焦的
			CHOPPED = "吃独食就算了，还不挖树根！",		-- 物品名:"桦树"->被砍了
			POISON = "好耶，好多好多的桦栗果",		-- 物品名:"桦树"->毒化的
			GENERIC = "要致富，砍树树~",		-- 物品名:"桦树"->默认
		},
		ACORN = "烤熟香香的！",		-- 物品名:"桦木果"
        ACORN_SAPLING = "快长大吧！",		-- 物品名:"桦树树苗"
		ACORN_COOKED = "好香香！",		-- 物品名:"烤桦木果"
		BIRCHNUTDRAKE = "你也想被我烤了吃吗？",		-- 物品名:"桦木果精"
		EVERGREEN =
		{
			BURNING = "我试试能不能灭火",		-- 物品名:"常青树"->正在燃烧
			BURNT = "骗你的啦，我就没想灭",		-- 物品名:"常青树"->烧焦的
			CHOPPED = "又不挖树根？？？",		-- 物品名:"常青树"->被砍了
			GENERIC = "要致富，砍树树~",		-- 物品名:"常青树"->默认
		},
		EVERGREEN_SPARSE =
		{
			BURNING = "我试试能不能灭火",		-- 物品名:"粗壮常青树"->正在燃烧
			BURNT = "骗你的啦，我就没想灭~",		-- 物品名:"粗壮常青树"->烧焦的
			CHOPPED = "砍树不挖树根的大黑蛋子！",		-- 物品名:"粗壮常青树"->被砍了
			GENERIC = "断子绝孙树！",		-- 物品名:"粗壮常青树"->默认
		},
		TWIGGYTREE = 
		{
			BURNING = "灭了火我们吃沙拉！",		-- 物品名:"繁茂的树木"->正在燃烧
			BURNT = "我的沙拉吃不到惹！",		-- 物品名:"繁茂的树木"->烧焦的
			CHOPPED = "烧了算了",		-- 物品名:"繁茂的树木"->被砍了
			GENERIC = "春天要来了吗",					-- 物品名:"繁茂的树木"->默认
			DISEASED = "我可不做没有好处的事！",		-- 物品名:"繁茂的树木"->生病了
		},
		TWIGGY_NUT_SAPLING = "假的小树枝！",		-- 物品名:"繁茂的树苗"
        TWIGGY_OLD = "哦豁，熟过头了",		-- 物品名:"繁茂的树木"
		TWIGGY_NUT = "做沙拉吃！",		-- 物品名:"繁茂的针叶树"->多枝树果
		EYEPLANT = "啊啊啊，我被眼睛咬了！",		-- 物品名:"眼球草"
		INSPECTSELF = "这位闭月羞花的小美女是谁呢？没错，就是我！",		-- 物品名:"繁茂的树木"->检查自己
		FARMPLOT =
		{
			GENERIC = "能种出蔬菜？！",		-- 物品名:未找到
			GROWING = "成长中的小吃！",		-- 物品名:未找到
			NEEDSFERTILIZER = "放一些便便在上面！",		-- 物品名:未找到
			BURNT = "烧的太焦，不能种植",		-- 物品名:未找到
		},
		FEATHERHAT = "鸟儿们送我的！！",		-- 物品名:"羽毛帽" 制造描述:"头上的装饰"
		FEATHER_CROW = "乌鸦留下的",		-- 物品名:"黑色羽毛"
		FEATHER_ROBIN = "红雀留下的",		-- 物品名:"红色羽毛"
		FEATHER_ROBIN_WINTER = "雪雀留下的",		-- 物品名:"雪雀羽毛"
		FEATHER_CANARY = "小偷包包的赠品!",		-- 物品名:"橙黄羽毛"
		FEATHERPENCIL = "还是喜欢粉嫩一点",		-- 物品名:"羽毛笔" 制造描述:"是的，羽毛是必须的"
		FEM_PUPPET = "困住了吗？",		-- 物品名:未找到
		FIREFLIES =
		{
			GENERIC = "一闪一闪亮晶晶！",		-- 物品名:"萤火虫"->默认
			HELD = "可惜不能吃",		-- 物品名:"萤火虫"->拿在手里
		},
		FIREHOUND = "好帅气的狗狗，要养在家里！",		-- 物品名:"火猎犬"
		FIREPIT =
		{
			EMBERS = "要灭了喔",		-- 物品名:"石头营火"->即将熄灭 制造描述:"一种更安全、更高效的营火"
			GENERIC = "想喝奶茶了",		-- 物品名:"石头营火"->默认 制造描述:"一种更安全、更高效的营火"
			HIGH = "别被烫到了！",		-- 物品名:"石头营火"->高 制造描述:"一种更安全、更高效的营火"
			LOW = "小火苗在燃烧",		-- 物品名:"石头营火"->低？ 制造描述:"一种更安全、更高效的营火"
			NORMAL = "刚刚好",		-- 物品名:"石头营火"->普通 制造描述:"一种更安全、更高效的营火"
			OUT = "烤肉吧！",		-- 物品名:"石头营火"->出去？外面？ 制造描述:"一种更安全、更高效的营火"
		},
		COLDFIREPIT =
		{
			EMBERS = "要灭了喔",		-- 物品名:"石头冰火"->即将熄灭 制造描述:"燃烧效率更高，但仍然越烤越冷"
			GENERIC = "想喝冰奶茶了",		-- 物品名:"石头冰火"->默认 制造描述:"燃烧效率更高，但仍然越烤越冷"
			HIGH = "别被冻伤了！",		-- 物品名:"石头冰火"->高 制造描述:"燃烧效率更高，但仍然越烤越冷"
			LOW = "小火苗在燃烧",		-- 物品名:"石头冰火"->低？ 制造描述:"燃烧效率更高，但仍然越烤越冷"
			NORMAL = "蓝色的火！！",		-- 物品名:"石头冰火"->普通 制造描述:"燃烧效率更高，但仍然越烤越冷"
			OUT = "蓝色的火！！",		-- 物品名:"石头冰火"->出去？外面？ 制造描述:"燃烧效率更高，但仍然越烤越冷"
		},
		FIRESTAFF = "可以用来远距离打开箱子哦",		-- 物品名:"火魔杖" 制造描述:"利用火焰的力量！"
		FIRESUPPRESSOR = 
		{	
			ON = "还是好人多！！",		-- 物品名:"雪球发射器"->开启 制造描述:"拯救植物，扑灭火焰，可添加燃料"
			OFF = "机器在睡觉！",		-- 物品名:"雪球发射器"->关闭 制造描述:"拯救植物，扑灭火焰，可添加燃料"
			LOWFUEL = "会有人加燃料的吧？",		-- 物品名:"雪球发射器"->燃料不足 制造描述:"拯救植物，扑灭火焰，可添加燃料"
		},
		FISH = "看上起来很好吃的样子，做成红烧鱼吧！",		-- 物品名:"鱼"
		FISHINGROD = "今天我就是姜太公！",		-- 物品名:"钓竿" 制造描述:"去钓鱼为了鱼"
		FISHSTICKS = "炸鱼排一定很好吃！",		-- 物品名:"炸鱼排"
		FISHTACOS = "鱼肉玉米卷一定很好吃！",		-- 物品名:"鱼肉玉米卷"
		FISH_COOKED = "也许该加点调味料？",		-- 物品名:"烤鱼"
		FLINT = "尖锐的石头，可以做成工具！",		-- 物品名:"燧石"
		FLOWER = 
		{
		    GENERIC = "果冻！果冻！",		-- 物品名:"花"->默认
            ROSE = "扎人的果冻",		-- 物品名:"花"->玫瑰
        },
        FLOWER_WITHERED = "草，一种花！",		-- 物品名:"枯萎的花"
		FLOWERHAT = "编一个送给阿鹿姐姐吧！",		-- 物品名:"花环" 制造描述:"放松神经的东西"
		FLOWER_EVIL = "奇怪的花",		-- 物品名:"邪恶花"
		FOLIAGE = "不好吃……",		-- 物品名:"蕨叶"
		FOOTBALLHAT = "猪猪保护我！！",		-- 物品名:"橄榄球头盔" 制造描述:"保护你的脑壳"
        FOSSIL_PIECE = "还没吃到就灭绝了，好可惜",		-- 物品名:"化石碎片"
        FOSSIL_STALKER =
        {
			GENERIC = "还需要零件",		-- 物品名:"化石骨架"->默认
			FUNNY = "原本是这长这样吗？",		-- 物品名:"化石骨架"->趣味？？
			COMPLETE = "还差点什么",		-- 物品名:"化石骨架"->准备好了
        },
        STALKER = "这就是黑暗魔法吗？",		-- 物品名:"复活的骨架"
        STALKER_ATRIUM = "又不能吃，不是很想战斗！",		-- 物品名:"远古织影者"
        STALKER_MINION = "这个不会好吃的吧！",		-- 物品名:"编织暗影"
        THURIBLE = "魔法？",		-- 物品名:"影子香炉"
        ATRIUM_OVERGROWTH = "古代人就是用这个的嘛？",		-- 物品名:"古代的方尖碑"
		FROG =
		{
			DEAD = "蛙蛙？",		-- 物品名:"青蛙"->死了
			GENERIC = "涮火锅应该很棒",		-- 物品名:"青蛙"->默认
			SLEEPING = "温水煮",		-- 物品名:"青蛙"->睡着了
		},
		FROGGLEBUNWICH = "味道还可以！",		-- 物品名:"蛙腿三明治"
		FROGLEGS = "青蛙的腿，涮火锅！",		-- 物品名:"蛙腿"
		FROGLEGS_COOKED = "应该加点调料？",		-- 物品名:"烤蛙腿"
		FRUITMEDLEY = "好吃，阿鹿也会喜欢的吧！",		-- 物品名:"水果圣代"
		FURTUFT = "可以用来泡酒！", 		-- 物品名:"毛丛"
		GEARS = "零件",		-- 物品名:"齿轮"
		GHOST = "好可怜，一定是饿死的",		-- 物品名:"幽灵"
		GOLDENAXE = "工具升级！",		-- 物品名:"黄金斧头" 制造描述:"砍树也要有调！"
		GOLDENPICKAXE = "工具升级",		-- 物品名:"黄金鹤嘴锄" 制造描述:"像大Boss一样砸碎岩石"
		GOLDENPITCHFORK = "工具升级！",		-- 物品名:"黄金干草叉" 制造描述:"重新布置整个世界"
		GOLDENSHOVEL = "工具升级！",		-- 物品名:"黄金铲子" 制造描述:"挖掘作用相同，但使用寿命更长"
		GOLDNUGGET = "肉肉换的！",		-- 物品名:"金块"
		GRASS =
		{
			BARREN = "草，一种植物！",		-- 物品名:"草"
			WITHERED = "它干巴了",		-- 物品名:"草"->枯萎了
			BURNING = "火焰草!",		-- 物品名:"草"->正在燃烧
			GENERIC = "草，一种植物！",		-- 物品名:"草"->默认
			PICKED = "早，秃了",		-- 物品名:"草"->被采完了
			DISEASED = "要治好它吗？",		-- 物品名:"草"->生病了
			DISEASING = "要治好它吗？",		-- 物品名:"草"->正在生病？？
		},
		GRASSGEKKO = 
		{
			GENERIC = "草，一种动物？",			-- 物品名:"草地壁虎"->默认
			DISEASED = "要治好它吗？",		-- 物品名:"草地壁虎"->生病了
		},
		GREEN_CAP = "切下来的哥布林的**",		-- 物品名:"采摘的绿蘑菇"
		GREEN_CAP_COOKED = "熟哥布林！！",		  -- 物品名:"烤绿蘑菇"
		GREEN_MUSHROOM =
		{
			GENERIC = "哥布林蘑菇",		-- 物品名:"绿蘑菇"->默认
			INGROUND = "可千万别冒头",		-- 物品名:"绿蘑菇"->在地里面
			PICKED = "被圣女吃掉了！",		-- 物品名:"绿蘑菇"->被采完了
		},
		GUNPOWDER = "可以用来取暖",		-- 物品名:"火药" 制造描述:"一把火药"
		HAMBAT = "大肉棒！",		-- 物品名:"火腿棒" 制造描述:"舍不得火腿套不着狼"
		HAMMER = "是个锤子",		-- 物品名:"锤子" 制造描述:"敲碎各种东西"
		HEALINGSALVE = "治疗用的药膏？",		-- 物品名:"治疗药膏" 制造描述:"对割伤和擦伤进行消毒杀菌"
		HEATROCK =
		{
			FROZEN = "炎热退散",		-- 物品名:"暖石"->冰冻 制造描述:"储存热能供旅行途中使用"
			COLD = "好冷了！",		-- 物品名:"冻伤"->冷了
			GENERIC = "喜欢鹿鹿！",		-- 物品名:"暖石"->默认 制造描述:"储存热能供旅行途中使用"
			WARM = "寒冷退散",		-- 物品名:"暖石"->温暖 制造描述:"储存热能供旅行途中使用"
			HOT = "太烫了！",		-- 物品名:"中暑"->热了
		},
		HOME = "是我的了！",		-- 物品名:"暖石"->没调用 制造描述:"储存热能供旅行途中使用"
		HOMESIGN =
		{
			GENERIC = "下一站是哪？",		-- 物品名:"路牌"->默认 制造描述:"在世界中留下你的标记"
            UNWRITTEN = "上面什么也没有",		-- 物品名:"路牌"->没有写字 制造描述:"在世界中留下你的标记"
			BURNT = "没用标记",		-- 物品名:"路牌"->烧焦的 制造描述:"在世界中留下你的标记"
		},
		ARROWSIGN_POST =
		{
			GENERIC = "下一站是哪？",		-- 物品名:"指路标志"->默认 制造描述:"对这个世界指指点点或许只是打下手势"
            UNWRITTEN = "上面什么也没有！",		-- 物品名:"指路标志"->没有写字 制造描述:"对这个世界指指点点或许只是打下手势"
			BURNT = "没用标记",		-- 物品名:"指路标志"->烧焦的 制造描述:"对这个世界指指点点或许只是打下手势"
		},
		ARROWSIGN_PANEL =
		{
			GENERIC = "下一站是哪？",		-- 物品名:"指路标志"->默认
            UNWRITTEN = "上面什么也没有！",		-- 物品名:"指路标志"->没有写字
			BURNT = "没用标记",		-- 物品名:"指路标志"->烧焦的
		},
		HONEY = "好甜甜！",		-- 物品名:"蜂蜜"
		HONEYCOMB = "蜜蜂的巢穴！",		-- 物品名:"蜂巢"
		HONEYHAM = "蜜汁猪猪！",		-- 物品名:"蜜汁火腿"
		HONEYNUGGETS = "蜜汁兔兔！",		-- 物品名:"蜜汁卤肉"
		HORN = "牛牛的角",		-- 物品名:"牛角"
		HOUND = "你在狗叫什么？",		-- 物品名:"猎犬"
		HOUNDCORPSE =
		{
			GENERIC = "嘬嘬嘬~",		-- 物品名:"猎犬"->默认
			BURNING = "有点香？",		-- 物品名:"猎犬"->正在燃烧
			REVIVING = "嘬嘬嘬~",		-- 物品名:"猎犬"
		},
		HOUNDBONE = "吃剩的狗狗（其实是打飞的）",		-- 物品名:"犬骨"
		HOUNDMOUND = "狗狗的窝",		-- 物品名:"猎犬丘"
		ICEBOX = "还不如放背包里呢",		-- 物品名:"冰箱" 制造描述:"延缓食物变质"
		ICEHAT = "好冷",		-- 物品名:"冰帽" 制造描述:"用科学技术合成的冰帽"
		ICEHOUND = "bingo！",		-- 物品名:"冰猎犬"
		INSANITYROCK =
		{
			ACTIVE = "它在伸缩耶",		-- 物品名:"方尖碑"->激活了
			INACTIVE = "古代的人真会玩",		-- 物品名:"方尖碑"->没有激活
		},
		JAMMYPRESERVES = "有猪，我不说是谁",		-- 物品名:"果酱"
		KABOBS = "只能吃这个了嘛……",		-- 物品名:"肉串"
		KILLERBEE =
		{
			GENERIC = "肉眼可见的红了！",		-- 物品名:"杀人蜂"->默认
			HELD = "嗡嗡嗡~",		-- 物品名:"杀人蜂"->拿在手里
		},
		KNIGHT = "仿生马儿顶顶顶！",		-- 物品名:"发条骑士"
		KOALEFANT_SUMMER = "好吃！",		-- 物品名:"大象"
		KOALEFANT_WINTER = "好吃又好穿！",		-- 物品名:"大象"
		KRAMPUS = "东西给你，包包给我",		-- 物品名:"坎普斯"
		KRAMPUS_SACK = "坎普斯的谢礼！（厚礼谢）",		-- 物品名:"坎普斯背包"
		LEIF = "吃不得",		-- 物品名:"树精守卫"
		LEIF_SPARSE = "大黑蛋子福音",		-- 物品名:"树精守卫"
		LIGHTER  = "oi，来个火",		-- 物品名:"薇洛的打火机" 制造描述:"火焰在雨中彻夜燃烧"
		LIGHTNING_ROD =
		{
			CHARGED = "just避雷！",		-- 物品名:"避雷针" 制造描述:"防雷劈"
			GENERIC = "just避雷！",		-- 物品名:"避雷针"->默认 制造描述:"防雷劈"
		},
		LIGHTNINGGOAT = 
		{
			GENERIC = "胡说，羊奶怎么会是它身上挤出来的",		-- 物品名:"闪电羊"->默认
			CHARGED = "闪电魔法？",		-- 物品名:"闪电羊"
		},
		LIGHTNINGGOATHORN = "可以拿来做点肉冻吃，酥酥麻麻！",		-- 物品名:"闪电羊角"
		GOATMILK = "都是科技与狠活！！",		-- 物品名:"带电的羊奶"
		LITTLE_WALRUS = "你好吖，要不要步行手杖我送你一个",		-- 物品名:"小海象人"
		LIVINGLOG = "强大的魔法",		-- 物品名:"活木头" 制造描述:"用你的身体来代替\n你该干的活吧"
		LOG =
		{
			BURNING = "在燃烧中的木头！",		-- 物品名:"木头"->正在燃烧
			GENERIC = "做个火堆吧？",		-- 物品名:"木头"->默认
		},
		LUCY = "有恋爱脑的斧子。",		-- 物品名:"露西斧"
		LUREPLANT = "种肉肉！",		-- 物品名:"食人花"
		LUREPLANTBULB = "好东西哦",		-- 物品名:"食人花种子"
		MALE_PUPPET = "不动了？",		-- 物品名:"木头"
		MANDRAKE_ACTIVE = "你没事吧？",		-- 物品名:"曼德拉草"
		MANDRAKE_PLANTED = "怕阳光的植物",		-- 物品名:"曼德拉草"
		MANDRAKE = "停止了活动",		-- 物品名:"曼德拉草"
        MANDRAKESOUP = "你很会叫哦！",		-- 物品名:"曼德拉草汤"
        MANDRAKE_COOKED = "厨具吗？",		-- 物品名:"木头"
        MAPSCROLL = "我很需要这个，来告诉大家我看了什么",		-- 物品名:"地图" 制造描述:"向别人展示你看到什么！"
        MARBLE = "白色石头",		-- 物品名:"大理石"
        MARBLEBEAN = "生长的石头",		-- 物品名:"大理石豌豆" 制造描述:"种植一片大理石森林"
        MARBLEBEAN_SAPLING = "科学不复存在了",		-- 物品名:"大理石芽"
        MARBLESHRUB = "石头森林！",		-- 物品名:"大理石灌木"
        MARBLEPILLAR = "有点历史了",		-- 物品名:"大理石柱"
        MARBLETREE = "石头森林！",		-- 物品名:"大理石树"
        MARSH_BUSH =
        {
			BURNT = "黑色也是一种美",		-- 物品名:"尖刺灌木"->烧焦的
            BURNING = "带来了光亮",		-- 物品名:"尖刺灌木"->正在燃烧
            GENERIC = "扎手手！",		-- 物品名:"尖刺灌木"->默认
            PICKED = "无了！",		-- 物品名:"尖刺灌木"->被采完了
        },
        BURNT_MARSH_BUSH = "扎手手！",		-- 物品名:"尖刺灌木"
        MARSH_PLANT = "沼泽植物",		-- 物品名:"池塘边植物"
        MARSH_TREE =
        {
            BURNING = "带来了光亮",		-- 物品名:"针刺树"->正在燃烧
            BURNT = "黑色也是一种美",		-- 物品名:"针刺树"->烧焦的
            CHOPPED = "还会再长出来吧",		-- 物品名:"针刺树"->被砍了
            GENERIC = "尖锐的植物",		-- 物品名:"针刺树"->默认
        },
        MAXWELL = "呵，男人",		-- 物品名:"麦斯威尔"->单机 麦斯威尔
        MAXWELLHEAD = "好丑！",		-- 物品名:"麦斯威尔的头"->单机 麦斯威尔的头
        MAXWELLLIGHT = "好丑！",		-- 物品名:"麦斯威尔灯"->单机 麦斯威尔的灯
        MAXWELLLOCK = "需要钥匙？",		-- 物品名:"噩梦锁"->单机 麦斯威尔的噩梦锁
        MAXWELLTHRONE = "诡异的座椅",		-- 物品名:"噩梦王座"->单机 麦斯威尔的噩梦王座
        MEAT = "也许可以用来煲汤",		-- 物品名:"肉"
        MEATBALLS = "队友饲料",		-- 物品名:"肉丸"
        MEATRACK =
        {
            DONE = "吃不完的肉肉晾干吃",		-- 物品名:"晾肉架"->完成了 制造描述:"晾肉的架子"
            DRYING = "晾肉干要好久哦",		-- 物品名:"晾肉架"->正在风干 制造描述:"晾肉的架子"
            DRYINGINRAIN = "这该死的雨！",		-- 物品名:"晾肉架"->雨天风干 制造描述:"晾肉的架子"
            GENERIC = "终于做好了",		-- 物品名:"晾肉架"->默认 制造描述:"晾肉的架子"
            BURNT = "哦不，我的肉干！",		-- 物品名:"晾肉架"->烧焦的 制造描述:"晾肉的架子"
            DONE_NOTMEAT = "终于做好了",		-- 物品名:"晾肉架" 制造描述:"晾肉的架子"
            DRYING_NOTMEAT = "终于做好了",		-- 物品名:"晾肉架" 制造描述:"晾肉的架子"
            DRYINGINRAIN_NOTMEAT = "终于做好了",		-- 物品名:"晾肉架" 制造描述:"晾肉的架子"
        },
        MEAT_DRIED = "好吃的肉干",		-- 物品名:"风干肉"
        MERM = "不像能吃的样子",		-- 物品名:"鱼人"
        MERMHEAD =
        {
            GENERIC = "臭杂鱼？",		-- 物品名:"鱼头"->默认
            BURNT = "熟杂鱼",		-- 物品名:"鱼头"->烧焦的
        },
        MERMHOUSE =
        {
            GENERIC = "里面在打麻将",		-- 物品名:"漏雨的小屋"->默认
            BURNT = "打不了麻将了",		-- 物品名:"漏雨的小屋"->烧焦的
        },
        MINERHAT = "便利的灯",		-- 物品名:"矿工帽" 制造描述:"用你脑袋上的灯照亮夜晚"
        MONKEY = "欢欢？",		-- 物品名:"暴躁猴"
        MONKEYBARREL = "猴子窝",		-- 物品名:"猴子桶"
        MONSTERLASAGNA = "做一堆偷偷放队友冰箱里",		-- 物品名:"怪物千层饼"
        FLOWERSALAD = "吃花花~",		-- 物品名:"花沙拉"
        ICECREAM = "好凉凉！！",		-- 物品名:"冰淇淋"
        WATERMELONICLE = "小西瓜",		-- 物品名:"西瓜冰棍"
        TRAILMIX = "三只老鼠！",		-- 物品名:"什锦干果"
        HOTCHILI = "好辣辣！",		-- 物品名:"辣椒炖肉"
        GUACAMOLE = "鼹鼠做的！",		-- 物品名:"鳄梨酱"
        MONSTERMEAT = "去掉头就可以吃了",		-- 物品名:"怪物肉"
        MONSTERMEAT_DRIED = "嘎嘣脆，鸡肉味",		-- 物品名:"怪物肉干"
        MOOSE = "可以用来煲汤？",		-- 物品名:"漏雨的小屋"
        MOOSE_NESTING_GROUND = "鹅的巢穴",		-- 物品名:"漏雨的小屋"
        MOOSEEGG = "动物的卵",		-- 物品名:"漏雨的小屋"
        MOSSLING = "嘎嘎嘎",		-- 物品名:"驼鹿鹅幼崽"
        FEATHERFAN = "吃剩的小鸭子做的扇子",		-- 物品名:"羽毛扇" 制造描述:"超柔软、超大的扇子"
        MINIFAN = "没有自动的吗？",		-- 物品名:"旋转的风扇" 制造描述:"你得跑起来，才能带来风！"
        GOOSE_FEATHER = "吃剩的小鸭子",		-- 物品名:"鹿鸭羽毛"
        STAFF_TORNADO = "用鸭鸭和咩咩做的武器",		-- 物品名:"天气风向标" 制造描述:"把你的敌人吹走"
        MOSQUITO =
        {
            GENERIC = "踩死你！",		-- 物品名:"蚊子"->默认
            HELD = "只取下血囊的话应该不会死吧",		-- 物品名:"蚊子"->拿在手里
        },
        MOSQUITOSACK = "蚊子的肚肚？",		-- 物品名:"蚊子血囊"
        MOUND =
        {
            DUG = "我超，硬币你妈坟被人挖了！！！",		-- 物品名:"坟墓"->被挖了
            GENERIC = "里面肯定有好东西",		-- 物品名:"坟墓"->默认
        },
        NIGHTLIGHT = "有点暗淡了",		-- 物品名:"魂灯" 制造描述:"用你的噩梦点亮夜晚"
        NIGHTMAREFUEL = "黑暗魔法！",		-- 物品名:"噩梦燃料" 制造描述:"傻子和疯子使用的邪恶残渣"
        NIGHTSWORD = "我的影刀有电羊",		-- 物品名:"暗夜剑" 制造描述:"造成噩梦般的伤害"
        NITRE = "硝石？",		-- 物品名:"硝石"
        ONEMANBAND = "我是好人，你跟着我！",		-- 物品名:"独奏乐器" 制造描述:"疯子音乐家也有粉丝"
        OASISLAKE =
		{
			GENERIC = "好想脱光跳进去泡澡",		-- 物品名:"湖泊"->默认
			EMPTY = "还好没脱",		-- 物品名:"湖泊"
		},
        PANDORASCHEST = "宝箱怪？",		-- 物品名:"华丽箱子"
        PANFLUTE = "手慢无",		-- 物品名:"排箫" 制造描述:"抚慰凶猛野兽的音乐"
        PAPYRUS = "以后拉屎可以擦屁股了！",		-- 物品名:"莎草纸" 制造描述:"用于书写"
        WAXPAPER = "用这个可能擦不干净",		-- 物品名:"蜡纸" 制造描述:"用于打包东西"
        PENGUIN = "听说打它一下会触发特殊奖励",		-- 物品名:"企鹅"
        PERD = "哇，真的是你呀~",		-- 物品名:"火鸡"
        PEROGIES = "好吃不过饺子！",		-- 物品名:"波兰水饺"
        PETALS = "碎花花！",		-- 物品名:"花瓣"
        PETALS_EVIL = "粘屎的花花！",		-- 物品名:"恶魔花瓣"
        PHLEGM = "拌饭给队友吃！",		-- 物品名:"脓鼻涕"
        PICKAXE = "石镐！！",		-- 物品名:"鹤嘴锄" 制造描述:"凿碎岩石"
        PIGGYBACK = "背个猪猪在身上",		-- 物品名:"猪皮包" 制造描述:"能装许多东西，但会减慢你的速度"
        PIGHEAD =
        {
            GENERIC = "知非？",		-- 物品名:"猪头"->默认
            BURNT = "几天不见，知非怎么这么烧了",		-- 物品名:"猪头"->烧焦的
        },
        PIGHOUSE =
        {
            FULL = "非非在里面",		-- 物品名:"猪屋"->满了 制造描述:"可以住一只猪"
            GENERIC = "知非在吗？",		-- 物品名:"猪屋"->默认 制造描述:"可以住一只猪"
            LIGHTSOUT = "让我焯焯，小非猪！",		-- 物品名:"猪屋"->关灯了 制造描述:"可以住一只猪"
            BURNT = "烧了",		-- 物品名:"猪屋"->烧焦的 制造描述:"可以住一只猪"
        },
        PIGKING = "多金知非！",		-- 物品名:"猪王"
        PIGMAN =
        {
            DEAD = "小非猪死掉惹",		-- 物品名:"猪人"->死了
            FOLLOWER = "非人！",		-- 物品名:"猪人"->追随者
            GENERIC = "非非？",		-- 物品名:"猪人"->默认
            GUARD = "非非，我又不乱来",		-- 物品名:"猪人"->警戒
            WEREPIG = "非非被玩坏了",		-- 物品名:"猪人"->疯猪
        },
        PIGSKIN = "非非的尾巴？",		-- 物品名:"猪皮"
        PIGTENT = "一种仪式",		-- 物品名:"猪人"
        PIGTORCH = "一种仪式",		-- 物品名:"猪火炬"
        PINECONE = "生长！",		-- 物品名:"松果"
        PINECONE_SAPLING = "有种的",		-- 物品名:"常青树苗"
        LUMPY_SAPLING = "没种的",		-- 物品名:"有疙瘩的树苗"
        PITCHFORK = "把你叉出去",		-- 物品名:"干草叉" 制造描述:"铲地用具"
        PLANTMEAT = "我有个大胆的想法",		-- 物品名:"叶子肉"
        PLANTMEAT_COOKED = "好吃捏",		-- 物品名:"烤叶子肉"
        PLANT_NORMAL =
        {
            GENERIC = "多叶的绿植！",		-- 物品名:"农作物"->默认
            GROWING = "要来点催生魔法",		-- 物品名:"农作物"->正在生长
            READY = "新鲜蔬菜！",		-- 物品名:"农作物"->准备好的 满的
            WITHERED = "照料的不是很好",		-- 物品名:"农作物"->枯萎了
        },
        POMEGRANATE = "最好吃的水果",		-- 物品名:"石榴"
        POMEGRANATE_COOKED = "这还能烤的？",		-- 物品名:"切片熟石榴"
        POMEGRANATE_SEEDS = "鸟屎里找到的！",		-- 物品名:"石榴种子"
        POND = "可以洗脚",		-- 物品名:"池塘"
        POOP = "收好，队友会偷吃的",		-- 物品名:"肥料"
        FERTILIZER = "新鲜的木桶饭！",		-- 物品名:"便便桶" 制造描述:"少拉点在手上，多拉点在庄稼上"
        PUMPKIN = "可以做南瓜派了吧",		-- 物品名:"南瓜"
        PUMPKINCOOKIE = "一块钱四个！",		-- 物品名:"南瓜饼"
        PUMPKIN_COOKED = "难吃！",		-- 物品名:"烤南瓜"
        PUMPKIN_LANTERN = "一拳一个",		-- 物品名:"南瓜灯" 制造描述:"长着鬼脸的照明用具"
        PUMPKIN_SEEDS = "能种出南瓜！",		-- 物品名:"南瓜种子"
        PURPLEAMULET = "好东西！",		-- 物品名:"噩梦护符" 制造描述:"引起精神错乱"
        PURPLEGEM = "紫色的宝石",		-- 物品名:"紫宝石" 制造描述:"由两种颜色的宝石合成！"
        RABBIT =
        {
            GENERIC = "小兔叽",		-- 物品名:"兔子"->默认
            HELD = "可以用来煲汤",		-- 物品名:"兔子"->拿在手里
        },
        RABBITHOLE =
        {
            GENERIC = "里面有肉肉嘛？",		-- 物品名:"兔洞"->默认
            SPRING = "塌了",		-- 物品名:"兔洞"->春天 or 潮湿
        },
        RAINOMETER =
        {
            GENERIC = "一看就能知道下了多少雨",		-- 物品名:"雨量计"->默认 制造描述:"观测降雨机率"
            BURNT = "知不道了",		-- 物品名:"雨量计"->烧焦的 制造描述:"观测降雨机率"
        },
        RAINCOAT = "不会弄湿身体 ",		-- 物品名:"雨衣" 制造描述:"让你保持干燥的防水外套"
        RAINHAT = "不能打湿衣服",		-- 物品名:"防雨帽" 制造描述:"手感柔软，防雨必备"
        RATATOUILLE = "狗都不吃",		-- 物品名:"蔬菜大杂烩"
        RAZOR = "脱光全身的毛！",		-- 物品名:"剃刀" 制造描述:"剃掉你脏脏的山羊胡子"
        REDGEM = "绿色的宝石",		-- 物品名:"红宝石"
        RED_CAP = "采下的红伞伞！",		-- 物品名:"采摘的红蘑菇"
        RED_CAP_COOKED = "狗都不吃！",		-- 物品名:"烤红蘑菇"
        RED_MUSHROOM =
        {
            GENERIC = "红伞伞，炒饭饭！",		-- 物品名:"红蘑菇"->默认
            INGROUND = "萎了",		-- 物品名:"红蘑菇"->在地里面
            PICKED = "真有狗吃？",		-- 物品名:"红蘑菇"->被采完了
        },
        REEDS =
        {
            BURNING = "我的厕纸！",		-- 物品名:"芦苇"->正在燃烧
            GENERIC = "厕纸材料",		-- 物品名:"芦苇"->默认
            PICKED = "拿去擦屁股了",		-- 物品名:"芦苇"->被采完了
        },
        RELIC = "远古的气息",		-- 物品名:"废墟"
        RUINS_RUBBLE = "这里发生过什么？",		-- 物品名:"损毁的废墟"
        RUBBLE = "这是什么材质？",		-- 物品名:"碎石"
        RESEARCHLAB =
        {
            GENERIC = "这是科学机器",		-- 物品名:"科学机器"->默认 制造描述:"解锁新的合成配方！"
            BURNT = "这是烧焦的科学机器",		-- 物品名:"科学机器"->烧焦的 制造描述:"解锁新的合成配方！"
        },
        RESEARCHLAB2 =
        {
            GENERIC = "这是炼金引擎",		-- 物品名:"炼金引擎"->默认 制造描述:"解锁更多合成配方！"
            BURNT = "这是烧焦的炼金引擎",		-- 物品名:"炼金引擎"->烧焦的 制造描述:"解锁更多合成配方！"
        },
        RESEARCHLAB3 =
        {
            GENERIC = "这是魔法三角",		-- 物品名:"暗影操控器"->默认 制造描述:"这还是科学吗？"
            BURNT = "这是烈火魔法三角",		-- 物品名:"暗影操控器"->烧焦的 制造描述:"这还是科学吗？"
        },
        RESEARCHLAB4 =
        {
            GENERIC = "这是神奇帽子",		-- 物品名:"灵子分解器"->默认 制造描述:"增强高礼帽的魔力"
            BURNT = "这是不神奇帽子",		-- 物品名:"灵子分解器"->烧焦的 制造描述:"增强高礼帽的魔力"
        },
        RESURRECTIONSTATUE =
        {
            GENERIC = "这是哪吒",		-- 物品名:"替身人偶"->默认 制造描述:"以肉的力量让你重生"
            BURNT = "这是那乇",		-- 物品名:"替身人偶"->烧焦的 制造描述:"以肉的力量让你重生"
        },
        RESURRECTIONSTONE = "这是板板！",		-- 物品名:"复活石"
        ROBIN =
        {
            GENERIC = "红色的鸟",		-- 物品名:"红雀"->默认
            HELD = "这是红鸟",		-- 物品名:"红雀"->拿在手里
        },
        ROBIN_WINTER =
        {
            GENERIC = "蓝色的鸟",		-- 物品名:"雪雀"->默认
            HELD = "这是蓝鸟",		-- 物品名:"雪雀"->拿在手里
        },
        ROBOT_PUPPET = "被我逮到了吧！",		-- 物品名:"雪雀"
        ROCK_LIGHT =
        {
            GENERIC = "这是温泉",		-- 物品名:"熔岩坑"->默认
            OUT = "呣",		-- 物品名:"熔岩坑"->出去？外面？
            LOW = "变成石头了",		-- 物品名:"熔岩坑"->低？
            NORMAL = "感觉会有岩浆冒出来",		-- 物品名:"熔岩坑"->普通
        },
        CAVEIN_BOULDER =
        {
            GENERIC = "普通的岩石",		-- 物品名:"岩石"->默认
            RAISED = "够不到！",		-- 物品名:"岩石"->提高了？
        },
        ROCK = "这个是石头哦！",		-- 物品名:"岩石"
        PETRIFIED_TREE = "岁月的痕迹",		-- 物品名:"岩石"
        ROCK_PETRIFIED_TREE = "石头森林？",		-- 物品名:"石化树"
        ROCK_PETRIFIED_TREE_OLD = "石头森林？",		-- 物品名:"岩石"
        ROCK_ICE =
        {
            GENERIC = "我超，冰！",		-- 物品名:"迷你冰山"->默认
            MELTED = "我超，冰！",		-- 物品名:"迷你冰山"->融化了
        },
        ROCK_ICE_MELTED = "我超，水！",		-- 物品名:"融化的冰矿"
        ICE = "宝贝，快来吃冰啦！",		-- 物品名:"冰"
        ROCKS = "石头",		-- 物品名:"石头"
        ROOK = "顶人好痛的",		-- 物品名:"发条战车"
        ROPE = "捆绑play？",		-- 物品名:"绳子" 制造描述:"紧密编成的草绳，非常有用"
        ROTTENEGG = "做蛋糕给猪比们吃",		-- 物品名:"腐烂鸟蛋"
        ROYAL_JELLY = "蜂老大的屎！",		-- 物品名:"蜂王浆"
        JELLYBEAN = "我一分钟能吃60个！",		-- 物品名:"彩虹糖豆"
        SADDLE_BASIC = "没有翅膀管用？",		-- 物品名:"鞍具" 制造描述:"你坐在动物身上仅仅是理论上"
        SADDLE_RACE = "没有翅膀管用？",		-- 物品名:"轻鞍具" 制造描述:"抵消掉完成目标所花费的时间或许"
        SADDLE_WAR = "战斗的鞍具",		-- 物品名:"战争鞍具" 制造描述:"战场首领的王位"
        SADDLEHORN = "拆卸鞍具的工具",		-- 物品名:"鞍角" 制造描述:"把鞍具撬开"
        SALTLICK = "畜生的食物",		-- 物品名:"舔舔盐块" 制造描述:"好好喂养你家的牲畜"
        BRUSH = "痒痒挠！",		-- 物品名:"刷子" 制造描述:"减缓牦牛毛发的生长速度"
		SANITYROCK =
		{
			ACTIVE = "有不好的预觉",		-- 物品名:"方尖碑"->激活了
			INACTIVE = "黑暗魔法",		-- 物品名:"方尖碑"->没有激活
		},
		SAPLING =
		{
			BURNING = "野火！！！",		-- 物品名:"树苗"->正在燃烧
			WITHERED = "我看看降雨魔法怎么放",		-- 物品名:"树苗"->枯萎了
			GENERIC = "这里有树枝耶！",		-- 物品名:"树苗"->默认
			PICKED = "它好像秃了",		-- 物品名:"树苗"->被采完了
			DISEASED = "要治好它吗",		-- 物品名:"树苗"->生病了
			DISEASING = "有侵蚀的气息",		-- 物品名:"树苗"->正在生病？？
		},
   		SCARECROW = 
   		{
			GENERIC = "好丑",		-- 物品名:"友善的稻草人"->默认 制造描述:"模仿最新的秋季时尚"
			BURNING = "丑东西着火了",		-- 物品名:"友善的稻草人"->正在燃烧 制造描述:"模仿最新的秋季时尚"
			BURNT = "丑东西糊了",		-- 物品名:"友善的稻草人"->烧焦的 制造描述:"模仿最新的秋季时尚"
   		},
   		SCULPTINGTABLE=
   		{
			EMPTY = "来做工品吧！",		-- 物品名:"陶轮" 制造描述:"大理石在你手里将像黏土一样！"
			BLOCK = "来做工艺吧！",		-- 物品名:"陶轮"->锁住了 制造描述:"大理石在你手里将像黏土一样！"
			SCULPTURE = "终于做好了",		-- 物品名:"陶轮"->雕像做好了 制造描述:"大理石在你手里将像黏土一样！"
			BURNT = "已经失灵了吗",		-- 物品名:"陶轮"->烧焦的 制造描述:"大理石在你手里将像黏土一样！"
   		},
        SCULPTURE_KNIGHTHEAD = "塞子？",		-- 物品名:"可疑的大理石"
		SCULPTURE_KNIGHTBODY = 
		{
			COVERED = "挖一下",		-- 物品名:"大理石雕像"->被盖住了-三基佬雕像可以敲大理石的时候
			UNCOVERED = "头呢",		-- 物品名:"大理石雕像"->没有被盖住-三基佬雕像被开采后
			FINISHED = "修好了",		-- 物品名:"大理石雕像"->三基佬雕像修好了
			READY = "吃我一刀",		-- 物品名:"大理石雕像"->准备好的 满的
		},
        SCULPTURE_BISHOPHEAD = "灯炮？",		-- 物品名:"可疑的大理石"
		SCULPTURE_BISHOPBODY = 
		{
			COVERED = "挖一下？",		-- 物品名:"大理石雕像"->被盖住了-三基佬雕像可以敲大理石的时候
			UNCOVERED = "头呢",		-- 物品名:"大理石雕像"->没有被盖住-三基佬雕像被开采后
			FINISHED = "修好了",		-- 物品名:"大理石雕像"->三基佬雕像修好了
			READY = "吃我一拳",		-- 物品名:"大理石雕像"->准备好的 满的
		},
        SCULPTURE_ROOKNOSE = "牛子？",		-- 物品名:"可疑的大理石"
		SCULPTURE_ROOKBODY = 
		{
			COVERED = "挖一下？",		-- 物品名:"大理石雕像"->被盖住了-三基佬雕像可以敲大理石的时候
			UNCOVERED = "母的？",		-- 物品名:"大理石雕像"->没有被盖住-三基佬雕像被开采后
			FINISHED = "修好了",		-- 物品名:"大理石雕像"->三基佬雕像修好了
			READY = "吃我一jio",		-- 物品名:"大理石雕像"->准备好的 满的
		},
        GARGOYLE_HOUND = "天体魔法",		-- 物品名:"可疑的月亮石"
        GARGOYLE_WEREPIG = "天体魔法",		-- 物品名:"可疑的月亮石"
		SEEDS = "好东西，偷偷全吃了！",		-- 物品名:"种子"
		SEEDS_COOKED = "不是我烤的",		-- 物品名:"烤种子"
		SEWING_KIT = "我也想学手工！",		-- 物品名:"针线包" 制造描述:"缝补受损的衣物"
		SEWING_TAPE = "我也想学手工！",		-- 物品名:"可靠的胶布" 制造描述:"缝补受损的衣物"
		SHOVEL = "没什么用",		-- 物品名:"铲子" 制造描述:"挖掘各种各样的东西"
		SILK = "材料",		-- 物品名:"蜘蛛丝"
		SKELETON = "有笨比！",		-- 物品名:"骷髅"
		SCORCHED_SKELETON = "有烧货！",		-- 物品名:"易碎骨骼"
		SKULLCHEST = "不祥气息！",		-- 物品名:"骷髅箱"
		SMALLBIRD =
		{
			GENERIC = "真是小！",		-- 物品名:"小鸟"->默认
			HUNGRY = "鸟儿饿饿",		-- 物品名:"小鸟"->有点饿了
			STARVING = "鸟儿要咬人了",		-- 物品名:"小鸟"->挨饿
			SLEEPING = "要不趁它睡着放生吧！",		-- 物品名:"小鸟"->睡着了
		},
		SMALLMEAT = "小块肉肉",		-- 物品名:"小肉"
		SMALLMEAT_DRIED = "用来塞牙缝吧",		-- 物品名:"小风干肉"
		SPAT = "听说可以趁他睡觉剪羊毛！",		-- 物品名:"钢羊"
		SPEAR = "我的魔法棒呢？",		-- 物品名:"长矛" 制造描述:"使用尖的那一端"
		SPEAR_WATHGRITHR = "我的魔法棒呢？",		-- 物品名:"战斗长矛" 制造描述:"黄金使它更锋利"
		WATHGRITHRHAT = "我的魔法帽更好一点",		-- 物品名:"战斗头盔" 制造描述:"独角兽是你的保护神"
		SPIDER =
		{
			DEAD = "选错了对手！",		-- 物品名:"蜘蛛"->死了
			GENERIC = "一脚一个小蜘蛛",		-- 物品名:"蜘蛛"->默认
			SLEEPING = "趁黑下手",		-- 物品名:"蜘蛛"->睡着了
		},
		SPIDERDEN = "呜，脚被绊住了",		-- 物品名:"蜘蛛巢"
		SPIDEREGGSACK = "虫卵",		-- 物品名:"蜘蛛卵" 制造描述:"跟你的朋友寻求点帮助"
		SPIDERGLAND = "蛛蛛的皮鼓",		-- 物品名:"蜘蛛腺"
		SPIDERHAT = "大蛛蛛的头",		-- 物品名:"蜘蛛帽" 制造描述:"蜘蛛们会喊你\"妈妈\""
		SPIDERQUEEN = "你也是女王？",		-- 物品名:"蜘蛛女王"
		SPIDER_WARRIOR =
		{
			DEAD = "你选错了对手！",		-- 物品名:"蜘蛛战士"->死了
			GENERIC = "还是用魔法吧",		-- 物品名:"蜘蛛战士"->默认
			SLEEPING = "趁黑下手",		-- 物品名:"蜘蛛战士"->睡着了
		},
		SPOILED_FOOD = "偷偷吃然后猛猛炫包果种子",		-- 物品名:"腐烂食物"
        STAGEHAND =
        {
			AWAKE = "死远点好吗？？",		-- 物品名:"舞台"->醒了
			HIDING = "给你两锤！",		-- 物品名:"舞台"->藏起来了
        },
        STATUE_MARBLE = 
        {
            GENERIC = "挖一下？",		-- 物品名:"大理石雕像"->默认
            TYPE1 = "需要媒介",		-- 物品名:"大理石雕像"->类型1
            TYPE2 = "有悲伤的气息",		-- 物品名:"大理石雕像"->类型2
            TYPE3 = "我不讨厌艺术", --bird bath type statue		-- 物品名:"大理石雕像"
        },
		STATUEHARP = "我不是很讨厌艺术",		-- 物品名:"竖琴雕像"
		STATUEMAXWELL = "该换成我的雕像了！",		-- 物品名:"麦斯威尔雕像"
		STEELWOOL = "剃下来的，没有钢羊受到伤害",		-- 物品名:"钢丝绵"
		STINGER = "蜜蜂的屁股",		-- 物品名:"蜂刺"
		STRAWHAT = "清凉的感觉",		-- 物品名:"草帽" 制造描述:"帮助你保持清凉干爽"
		STUFFEDEGGPLANT = "蒜茄子",		-- 物品名:"酿茄子"
		SWEATERVEST = "朋克？",		-- 物品名:"犬牙背心" 制造描述:"粗糙，但挺时尚"
		REFLECTIVEVEST = "感觉不如大裤衩",		-- 物品名:"清凉夏装" 制造描述:"穿上这件时尚的背心，保持凉爽和清醒"
		HAWAIIANSHIRT = "太花俏了",		-- 物品名:"花衬衫" 制造描述:"适合夏日穿着，或在周五便装日穿着"
		TAFFY = "还可以！",		-- 物品名:"太妃糖"
		TALLBIRD = "它似乎没有脑子？",		-- 物品名:"高脚鸟"
		TALLBIRDEGG = "吃吧！",		-- 物品名:"高脚鸟蛋"
		TALLBIRDEGG_COOKED = "要填饱肚子的",		-- 物品名:"煎高脚鸟蛋"
		TALLBIRDEGG_CRACKED =
		{
			COLD = "要冻烂了啦！",		-- 物品名:"冻伤"->冷了
			GENERIC = "不如烤了吃",		-- 物品名:"孵化中的高脚鸟蛋"->默认
			HOT = "要熟了啦！",		-- 物品名:"中暑"->热了
			LONG = "还早着呢",		-- 物品名:"孵化中的高脚鸟蛋"->还需要很久
			SHORT = "这就是出生吗？",		-- 物品名:"孵化中的高脚鸟蛋"->很快了
		},
		TALLBIRDNEST =
		{
			GENERIC = "今晚加餐",		-- 物品名:"高脚鸟巢"->默认
			PICKED = "感觉会有好东西",		-- 物品名:"高脚鸟巢"->被采完了
		},
		TEENBIRD =
		{
			GENERIC = "快快长大",		-- 物品名:"小高脚鸟"->默认
			HUNGRY = "我开始嫌烦了",		-- 物品名:"小高脚鸟"->有点饿了
			STARVING = "要不弄死吧！",		-- 物品名:"小高脚鸟"->挨饿
			SLEEPING = "好好睡一觉",		-- 物品名:"小高脚鸟"->睡着了
		},
		TELEPORTATO_BASE =
		{
			ACTIVE = "传送魔法阵",		-- 物品名:"木制传送台"->激活了
			GENERIC = "传送魔法阵，通向哪里呢？",		-- 物品名:"木制传送台"->默认
			LOCKED = "需要媒介",		-- 物品名:"木制传送台"->锁住了
			PARTIAL = "不完整的魔法回路",		-- 物品名:"木制传送台"->已经有部分了
		},
		TELEPORTATO_BOX = "箱子形状的媒介",		-- 物品名:"盒状零件"
		TELEPORTATO_CRANK = "魔法电话？",		-- 物品名:"曲柄零件"
		TELEPORTATO_POTATO = "为什么不是金子？",		-- 物品名:"金属土豆状零件"
		TELEPORTATO_RING = "环装媒介",		-- 物品名:"环状零件"
		TELESTAFF = "穿越空间的法杖！",		-- 物品名:"传送魔杖" 制造描述:"穿越空间的法杖！穿越时间的装置需另外购买"
		TENT = 
		{
			GENERIC = "呜，真舒服~",		-- 物品名:"帐篷"->默认 制造描述:"回复精神值，但要花费时间并导致饥饿"
			BURNT = "家没了！",		-- 物品名:"帐篷"->烧焦的 制造描述:"回复精神值，但要花费时间并导致饥饿"
		},
		SIESTAHUT = 
		{
			GENERIC = "是不是还差个凉席？",		-- 物品名:"遮阳篷"->默认 制造描述:"躲避烈日，回复精神值"
			BURNT = "我的避暑床！",		-- 物品名:"遮阳篷"->烧焦的 制造描述:"躲避烈日，回复精神值"
		},
		TENTACLE = "触手，触手play？！",		-- 物品名:"触手"
		TENTACLESPIKE = "一打一个不吱声",		-- 物品名:"狼牙棒"
		TENTACLESPOTS = "吃剩的触手",		-- 物品名:"触手皮"
		TENTACLE_PILLAR = "还是大的好",		-- 物品名:"大触手"
        TENTACLE_PILLAR_HOLE = "空间魔法",		-- 物品名:"硕大的泥坑"
		TENTACLE_PILLAR_ARM = "小小的也很可爱",		-- 物品名:"小触手"
		TENTACLE_GARDEN = "触手的家吗",		-- 物品名:"大触手"
		TOPHAT = "绅士帽吗",		-- 物品名:"高礼帽" 制造描述:"最经典的帽子款式"
		TORCH = "可以烧家",		-- 物品名:"火炬" 制造描述:"可携带的光源"
		TRANSISTOR = "弓箭材料",		-- 物品名:"电子元件" 制造描述:"科学至上！滋滋滋！"
		TRAP = "小时候用这个就没成功过",		-- 物品名:"陷阱" 制造描述:"捕捉小型生物"
		TRAP_TEETH = "这下可以放心睡觉了",		-- 物品名:"犬牙陷阱" 制造描述:"弹出来并咬伤任何踩到它的东西"
		TRAP_TEETH_MAXWELL = "这下可以放心睡觉了",		-- 物品名:"麦斯威尔的尖牙陷阱" 制造描述:"弹出来并咬伤任何踩到它的东西"
		TREASURECHEST = 
		{
			GENERIC = "也许可以用来放点不想扔的垃圾",		-- 物品名:"木箱"->默认 制造描述:"一种结实的容器"
			BURNT = "糊掉了",		-- 物品名:"木箱"->烧焦的 制造描述:"一种结实的容器"
		},
		TREASURECHEST_TRAP = "宝箱怪？！",		-- 物品名:"宝箱"
		SACRED_CHEST = 
		{
			GENERIC = "这不是盗窃！",		-- 物品名:"古老的箱子"->默认
			LOCKED = "是自己打开的！",		-- 物品名:"古老的箱子"->锁住了
		},
		TREECLUMP = "这可不是盗窃！",		-- 物品名:"古老的箱子"
		TRINKET_1 = "小玻璃珠", --Melted Marbles		-- 物品名:"熔化的弹珠"
		TRINKET_2 = "死人吹过的", --Fake Kazoo		-- 物品名:"假卡祖笛"
		TRINKET_3 = "魔法绳结", --Gord's Knot		-- 物品名:"戈尔迪之结"
		TRINKET_4 = "精灵玩偶", --Gnome		-- 物品名:"地精玩偶"
		TRINKET_5 = "这是什么模型？", --Toy Rocketship		-- 物品名:"迷你火箭"
		TRINKET_6 = "弓箭材料", --Frazzled Wires		-- 物品名:"烂电线"
		TRINKET_7 = "这能卖钱吗？", --Ball and Cup		-- 物品名:"杯子和球玩具"
		TRINKET_8 = "也许可以用来堵住皮弗娄牛的屁股", --Rubber Bung		-- 物品名:"硬化橡胶塞"
		TRINKET_9 = "奇怪的扣子", --Mismatched Buttons		-- 物品名:"不搭的纽扣"
		TRINKET_10 = "恶趣味", --Dentures		-- 物品名:"二手假牙"
		TRINKET_11 = "也许我不是很喜欢这种类型", --Lying Robot		-- 物品名:"机器人玩偶"
		TRINKET_12 = "玩坏的触手！", --Dessicated Tentacle		-- 物品名:"干瘪的触手"
		TRINKET_13 = "可爱的玩偶", --Gnomette		-- 物品名:"可爱的小玩偶"
		TRINKET_14 = "这能卖钱吗？", --Leaky Teacup		-- 物品名:"漏水的茶杯"
		TRINKET_15 = "材料模型", --Pawn		-- 物品名:"白衣主教"
		TRINKET_16 = "材料模型", --Pawn		-- 物品名:"黑衣主教"
		TRINKET_17 = "也许不是很好用", --Bent Spork		-- 物品名:"弯曲的叉子"
		TRINKET_18 = "可以用来做八音盒吗？", --Trojan Horse		-- 物品名:"玩具木马"
		TRINKET_19 = "奇怪的衣服", --Unbalanced Top		-- 物品名:"失衡上衣"
		TRINKET_20 = "我可不需要这个", --Backscratcher		-- 物品名:"不求人"
		TRINKET_21 = "这能卖钱吗？", --Egg Beater		-- 物品名:"破搅拌器"
		TRINKET_22 = "这能卖钱吗？", --Frayed Yarn		-- 物品名:"磨损的纱线"
		TRINKET_23 = "呜，谁的东西？", --Shoehorn		-- 物品名:"鞋拔子"
		TRINKET_24 = "可爱的猫", --Lucky Cat Jar		-- 物品名:"幸运猫扎尔"
		TRINKET_25 = "这能卖钱吗？", --Air Unfreshener		-- 物品名:"臭气制造器"
		TRINKET_26 = "这能卖钱吗？", --Potato Cup		-- 物品名:"土豆杯"
		TRINKET_27 = "这能卖钱吗？", --Coat Hanger		-- 物品名:"钢丝衣架"
		TRINKET_28 = "材料模型", --Rook		-- 物品名:"白色战车"
        TRINKET_29 = "材料模型", --Rook		-- 物品名:"黑色战车"
        TRINKET_30 = "材料模型", --Knight		-- 物品名:"白色骑士"
        TRINKET_31 = "材料模型", --Knight		-- 物品名:"黑色骑士"
        TRINKET_32 = "这能卖钱吗？", --Cubic Zirconia Ball		-- 物品名:"立方氧化锆球"
        TRINKET_33 = "难看的戒指", --Spider Ring		-- 物品名:"蜘蛛指环"
        TRINKET_34 = "诅咒道具？", --Monkey Paw		-- 物品名:"猴子手掌"
        TRINKET_35 = "风铃麻麻吃了发现没用", --Empty Elixir		-- 物品名:"空的长生不老药"
        TRINKET_36 = "万圣节快到了？", --Faux fangs		-- 物品名:"人造尖牙"
        TRINKET_37 = "这不就是铅笔吗？", --Broken Stake		-- 物品名:"断桩"
        TRINKET_38 = "还不如我的远望魔法", -- Binoculars Griftlands trinket		-- 物品名:"双筒望远镜"
        TRINKET_39 = "半吊子", -- Lone Glove Griftlands trinket		-- 物品名:"单只手套"
        TRINKET_40 = "这能卖钱吗？", -- Snail Scale Griftlands trinket		-- 物品名:"蜗牛秤"
        TRINKET_41 = "这能卖钱吗？", -- Goop Canister Hot Lava trinket		-- 物品名:"黏液罐"
        TRINKET_42 = "这能卖钱吗？", -- Toy Cobra Hot Lava trinket		-- 物品名:"玩具眼镜蛇"
        TRINKET_43= "这能卖钱吗？", -- Crocodile Toy Hot Lava trinket		-- 物品名:"鳄鱼玩具"
        TRINKET_44 = "这能卖钱吗？", -- Broken Terrarium ONI trinket		-- 物品名:"破碎的玻璃罐"
        TRINKET_45 = "没有声音了", -- Odd Radio ONI trinket		-- 物品名:"奇怪的收音机"
        TRINKET_46 = "不能用了", -- Hairdryer ONI trinket		-- 物品名:"损坏的吹风机"
        LOST_TOY_1  = "这东西？",		-- 物品名:"遗失的玻璃球"
        LOST_TOY_2  = "这东西？",		-- 物品名:"多愁善感的卡祖笛"
        LOST_TOY_7  = "这东西？",		-- 物品名:"珍视的抽线陀螺"
        LOST_TOY_10 = "这东西？",		-- 物品名:"缺少的牙齿"
        LOST_TOY_11 = "这东西？",		-- 物品名:"珍贵的玩具机器人"
        LOST_TOY_14 = "这东西？",		-- 物品名:"妈妈最爱的茶杯"
        LOST_TOY_18 = "这东西？",		-- 物品名:"宝贵的玩具木马"
        LOST_TOY_19 = "这东西？",		-- 物品名:"最爱的陀螺"
        LOST_TOY_42 = "这东西？",		-- 物品名:"装错的玩具眼镜蛇"
        LOST_TOY_43 = "这东西？",		-- 物品名:"宠爱的鳄鱼玩具"
        HALLOWEENCANDY_1 = "甜",		-- 物品名:"糖果苹果"
        HALLOWEENCANDY_2 = "甜美！",		-- 物品名:"糖果玉米"
        HALLOWEENCANDY_3 = "差点味道",		-- 物品名:"不太甜的玉米"
        HALLOWEENCANDY_4 = "我不要！",		-- 物品名:"粘液蜘蛛"
        HALLOWEENCANDY_5 = "还不错",		-- 物品名:"浣猫糖果"
        HALLOWEENCANDY_6 = "味道不错",		-- 物品名:"\"葡萄干\""
        HALLOWEENCANDY_7 = "酸酸甜甜",		-- 物品名:"葡萄干"
        HALLOWEENCANDY_8 = "不怎么好看",		-- 物品名:"鬼魂波普"
        HALLOWEENCANDY_9 = "恶趣味",		-- 物品名:"果冻虫"
        HALLOWEENCANDY_10 = "恶趣味",		-- 物品名:"触须棒棒糖"
        HALLOWEENCANDY_11 = "好吃！",		-- 物品名:"巧克力猪"
        HALLOWEENCANDY_12 = "还可以", --ONI meal lice candy		-- 物品名:"糖果虱"
        HALLOWEENCANDY_13 = "稍微有点硬", --Griftlands themed candy		-- 物品名:"无敌硬糖"
        HALLOWEENCANDY_14 = "热热热！", --Hot Lava pepper candy		-- 物品名:"熔岩椒"
        CANDYBAG = "零食袋！",		-- 物品名:"糖果袋" 制造描述:"只带万圣夜好吃的东西"
		HALLOWEEN_ORNAMENT_1 = "一点小饰品",		-- 物品名:"幽灵装饰"
		HALLOWEEN_ORNAMENT_2 = "一点小饰品",		-- 物品名:"蝙蝠装饰"
		HALLOWEEN_ORNAMENT_3 = "一点小饰品", 		-- 物品名:"蜘蛛装饰"
		HALLOWEEN_ORNAMENT_4 = "一点小饰品",		-- 物品名:"触手装饰"
		HALLOWEEN_ORNAMENT_5 = "一点小饰品",		-- 物品名:"悬垂蜘蛛装饰"
		HALLOWEEN_ORNAMENT_6 = "一点小饰品", 		-- 物品名:"乌鸦装饰"
		HALLOWEENPOTION_DRINKS_WEAK = "陈旧物品",		-- 物品名:"古老的箱子"
		HALLOWEENPOTION_DRINKS_POTENT = "陈旧的箱子",		-- 物品名:"古老的箱子"
        HALLOWEENPOTION_BRAVERY = "有什么值钱的东西吗",		-- 物品名:"古老的箱子"
		HALLOWEENPOTION_MOON = "魔法精华液",		-- 物品名:"月亮精华液"
		HALLOWEENPOTION_FIRE_FX = "火花瓶", 		-- 物品名:"古老的箱子"
		MADSCIENCE_LAB = "美和梦幻",		-- 物品名:"疯狂科学家实验室" 制造描述:"疯狂实验无极限唯独神智有极限"
		LIVINGTREE_ROOT = "根也能用", 		-- 物品名:"完全正常的树根"
		LIVINGTREE_SAPLING = "魔法树",		-- 物品名:"完全正常的树苗"
        DRAGONHEADHAT = "没有我可爱",		-- 物品名:"幸运兽脑袋" 制造描述:"野兽装束的前端"
        DRAGONBODYHAT = "还挺喜庆的！",		-- 物品名:"幸运兽躯体" 制造描述:"野兽装束的中间部分"
        DRAGONTAILHAT = "这可不是cos！",		-- 物品名:"幸运兽尾巴" 制造描述:"野兽装束的尾端"
        PERDSHRINE =
        {
            GENERIC = "祭祀神坛",		-- 物品名:"火鸡神龛"->默认 制造描述:"供奉庄严的火鸡"
            EMPTY = "需要召唤",		-- 物品名:"火鸡神龛" 制造描述:"供奉庄严的火鸡"
            BURNT = "只剩焦炭",		-- 物品名:"火鸡神龛"->烧焦的 制造描述:"供奉庄严的火鸡"
        },
        REDLANTERN = "漂亮的装饰品",		-- 物品名:"红灯笼" 制造描述:"照亮你的路的幸运灯笼"
        LUCKY_GOLDNUGGET = "为什么不是真金？",		-- 物品名:"幸运黄金"
        FIRECRACKERS = "有点吵了",		-- 物品名:"红色爆竹" 制造描述:"用重击来庆祝！"
        PERDFAN = "运势魔法",		-- 物品名:"幸运扇" 制造描述:"额外的运气，超级多"
        REDPOUCH = "里面有什么？",		-- 物品名:"红袋子"
        WARGSHRINE = 
        {
            GENERIC = "祭祀神坛",		-- 物品名:"座狼龛"->默认 制造描述:"供奉黏土座狼"
            EMPTY = "也许它想吃象鼻？",		-- 物品名:"座狼龛" 制造描述:"供奉黏土座狼"
            BURNT = "只剩焦炭",		-- 物品名:"座狼龛"->烧焦的 制造描述:"供奉黏土座狼"
        },
        CLAYWARG = 
        {
        	GENERIC = "糖果成精了？",		-- 物品名:"黏土座狼"->默认
        	STATUE = "有东西要出来了",		-- 物品名:"黏土座狼"->雕像
        },
        CLAYHOUND = 
        {
        	GENERIC = "糖果做的狗？！",		-- 物品名:"黏土猎犬"->默认
        	STATUE = "有东西要出来了",		-- 物品名:"黏土猎犬"->雕像
        },
        HOUNDWHISTLE = "风铃哨？",		-- 物品名:"幸运哨子" 制造描述:"对野猎犬吹哨"
        CHESSPIECE_CLAYHOUND = "我可不会下棋",		-- 物品名:"猎犬棋子"
        CHESSPIECE_CLAYWARG = "我可不会下棋",		-- 物品名:"座狼棋子"
		PIGSHRINE =
		{
            GENERIC = "祭祀神坛",		-- 物品名:"猪神龛"->默认 制造描述:"为富有的猪献贡"
            EMPTY = "需要召唤",		-- 物品名:"猪神龛" 制造描述:"为富有的猪献贡"
            BURNT = "只剩焦炭",		-- 物品名:"猪神龛"->烧焦的 制造描述:"为富有的猪献贡"
		},
		PIG_TOKEN = "这东西能卖钱吗？",		-- 物品名:"金色腰带"
		PIG_COIN = "猪比猪比",		-- 物品名:"猪鼻铸币"
		YOTP_FOOD1 = "憨傻的兽人",		-- 物品名:"致敬烤肉" 制造描述:"向猪王敬肉"
		YOTP_FOOD2 = "泥巴馅饼？",		-- 物品名:"八宝泥馅饼" 制造描述:"那里隐藏着什么？"
		YOTP_FOOD3 = "浑浊的烧烤",		-- 物品名:"鱼头串" 制造描述:"棍子上的荣华富贵"
		PIGELITE1 = "麻烦离我远一点", --BLUE		-- 物品名:"韦德"
		PIGELITE2 = "麻烦离我远一点", --RED		-- 物品名:"伊内修斯"
		PIGELITE3 = "麻烦离我远一点", --WHITE		-- 物品名:"德米特里"
		PIGELITE4 = "麻烦离我远一点", --GREEN		-- 物品名:"索耶"
		PIGELITEFIGHTER1 = "麻烦离我远一点", --BLUE		-- 物品名:"韦德"
		PIGELITEFIGHTER2 = "麻烦离我远一点", --RED		-- 物品名:"伊内修斯"
		PIGELITEFIGHTER3 = "麻烦离我远一点", --WHITE		-- 物品名:"德米特里"
		PIGELITEFIGHTER4 = "麻烦离我远一点", --GREEN		-- 物品名:"索耶"
		CARRAT_GHOSTRACER = "成精的老鼠？",		-- 物品名:"查理的胡萝卜鼠"
        YOTC_CARRAT_RACE_START = "比赛从这开始！",		-- 物品名:"起点" 制造描述:"冲向比赛！"
        YOTC_CARRAT_RACE_CHECKPOINT = "它能指路！",		-- 物品名:"检查点" 制造描述:"通往光荣之路上的一站"
        YOTC_CARRAT_RACE_FINISH =
        {
            GENERIC = "这是终点",		-- 物品名:"终点线"->默认 制造描述:"你走投无路了"
            BURNT = "到此为止了",		-- 物品名:"终点线"->烧焦的 制造描述:"你走投无路了"
            I_WON = "到此为止了",		-- 物品名:"终点线" 制造描述:"你走投无路了"
            SOMEONE_ELSE_WON = "魔女的实力",		-- 物品名:"终点线" 制造描述:"你走投无路了"
        },
		YOTC_CARRAT_RACE_START_ITEM = "比赛的起点",		-- 物品名:"起点套装" 制造描述:"冲向比赛！"
        YOTC_CARRAT_RACE_CHECKPOINT_ITEM = "帮萝卜鼠找路",		-- 物品名:"检查点套装" 制造描述:"通往光荣之路上的一站"
		YOTC_CARRAT_RACE_FINISH_ITEM = "终点放在哪？",		-- 物品名:"终点线套装" 制造描述:"你走投无路了"
		YOTC_SEEDPACKET = "为什么不是零食？！",		-- 物品名:"种子包" 制造描述:"一包普通的混合种子"
		YOTC_SEEDPACKET_RARE = "为什么不是零食？",		-- 物品名:"高级种子包" 制造描述:"一包高质量的种子"
		MINIBOATLANTERN = "需要赶紧捡起来",		-- 物品名:"漂浮灯笼" 制造描述:"闪着暖暖的光亮"
        YOTC_CARRATSHRINE =
        {
            GENERIC = "祭祀神坛",		-- 物品名:"胡萝卜鼠神龛"->默认 制造描述:"供奉灵活的胡萝卜鼠"
            EMPTY = "需要召唤",		-- 物品名:"胡萝卜鼠神龛" 制造描述:"供奉灵活的胡萝卜鼠"
            BURNT = "不是我弄坏的！！",		-- 物品名:"胡萝卜鼠神龛"->烧焦的 制造描述:"供奉灵活的胡萝卜鼠"
        },
        YOTC_CARRAT_GYM_DIRECTION = 
        {
            GENERIC = "不愧是我的胡萝卜鼠！",		-- 物品名:"方向健身房"->默认
            RAT = "去吧！！",		-- 物品名:"方向健身房"
            BURNT = "需要复原",		-- 物品名:"方向健身房"->烧焦的
        },
        YOTC_CARRAT_GYM_SPEED = 
        {
            GENERIC = "竞速轮",		-- 物品名:"速度健身房"->默认
            RAT = "比速度可没怕过谁",		-- 物品名:"速度健身房"
            BURNT = "赶紧复原",		-- 物品名:"速度健身房"->烧焦的
        },
        YOTC_CARRAT_GYM_REACTION = 
        {
            GENERIC = "我不是很擅长跑步……",		-- 物品名:"反应健身房"->默认
            RAT = "提高了！",		-- 物品名:"反应健身房"
            BURNT = "赶紧复原",		-- 物品名:"反应健身房"->烧焦的
        },
        YOTC_CARRAT_GYM_STAMINA = 
        {
            GENERIC = "我不想运动！",		-- 物品名:"耐力健身房"->默认
            RAT = "跳啊！",		-- 物品名:"耐力健身房"
            BURNT = "需要赶紧复原",		-- 物品名:"耐力健身房"->烧焦的
        }, 
        YOTC_CARRAT_GYM_DIRECTION_ITEM = "我的胡萝卜鼠是最棒的！",		-- 物品名:"方向健身房套装" 制造描述:"提高你的胡萝卜鼠的方向感"
        YOTC_CARRAT_GYM_SPEED_ITEM = "给萝卜鼠的",		-- 物品名:"速度健身房套装" 制造描述:"增加你的胡萝卜鼠的速度"
        YOTC_CARRAT_GYM_STAMINA_ITEM = "给萝卜鼠的",		-- 物品名:"耐力健身房套装" 制造描述:"增强你的胡萝卜鼠的耐力"
        YOTC_CARRAT_GYM_REACTION_ITEM = "给萝卜鼠的",		-- 物品名:"反应健身房套装" 制造描述:"加快你的胡萝卜鼠的反应时间"
        YOTC_CARRAT_SCALE_ITEM = "也许我也该称称，还是算了！",           		-- 物品名:"胡萝卜鼠秤套装" 制造描述:"看看你的胡萝卜鼠的情况"
        YOTC_CARRAT_SCALE = 
        {
            GENERIC = "谁比较重？不要看我！",		-- 物品名:"胡萝卜鼠秤"->默认
            CARRAT = "不是很好",		-- 物品名:"胡萝卜" 制造描述:"灵巧机敏，富含胡萝卜素"
            CARRAT_GOOD = "会是个很好的选手！",		-- 物品名:"胡萝卜鼠秤"
            BURNT = "赶紧复原",		-- 物品名:"胡萝卜鼠秤"->烧焦的
        },                
		BISHOP_CHARGE_HIT = "胡萝！",		-- 物品名:"胡萝卜鼠秤"->被主教攻击
		TRUNKVEST_SUMMER = "暖和些了",		-- 物品名:"保暖小背心" 制造描述:"暖和，但算不上非常暖和"
		TRUNKVEST_WINTER = "很暖和！",		-- 物品名:"寒冬背心" 制造描述:"足以抵御冬季暴雪的保暖背心"
		TRUNK_COOKED = "香气飘出来了",		-- 物品名:"象鼻排"
		TRUNK_SUMMER = "烤烤更美味！",		-- 物品名:"象鼻"
		TRUNK_WINTER = "烤烤更美味",		-- 物品名:"冬象鼻"
		TUMBLEWEED = "它从哪里来？",		-- 物品名:"风滚草"
		TURKEYDINNER = "感恩节料理",		-- 物品名:"火鸡大餐"
		TWIGS = "魔法棒材料",		-- 物品名:"树枝"
		UMBRELLA = "去迎接风雨",		-- 物品名:"雨伞" 制造描述:"遮阳挡雨！"
		GRASS_UMBRELLA = "可爱的我需要可爱的伞！",		-- 物品名:"花伞" 制造描述:"漂亮轻便的保护伞"
		UNIMPLEMENTED = "给胡萝卜鼠吧？",		-- 物品名:"胡萝卜鼠秤"
		WAFFLES = "甜饼",		-- 物品名:"华夫饼"
		WALL_HAY = 
		{	
			GENERIC = "草做的墙！",		-- 物品名:"草墙"->默认
			BURNT = "没了",		-- 物品名:"草墙"->烧焦的
		},
		WALL_HAY_ITEM = "高高的谷堆",		-- 物品名:"草墙" 制造描述:"草墙墙体不太结实"
		WALL_STONE = "结实的墙！",		-- 物品名:"石墙"
		WALL_STONE_ITEM = "石头墙",		-- 物品名:"石墙" 制造描述:"石墙墙体"
		WALL_RUINS = "橙色的墙！",		-- 物品名:"铥墙"
		WALL_RUINS_ITEM = "看上去贵的样子！",		-- 物品名:"铥墙" 制造描述:"这些墙可以承受相当多的打击"
		WALL_WOOD = 
		{
			GENERIC = "木墙实心吗？",		-- 物品名:"木墙"->默认
			BURNT = "已经没用了",		-- 物品名:"木墙"->烧焦的
		},
		WALL_WOOD_ITEM = "木墙实心吗？",		-- 物品名:"木墙" 制造描述:"木墙墙体"
		WALL_MOONROCK = "天体的气息",		-- 物品名:"月岩壁"
		WALL_MOONROCK_ITEM = "晶莹的墙壁",		-- 物品名:"月岩壁" 制造描述:"月球疯子之墙"
		FENCE = "可以种点花",		-- 物品名:"木栅栏"
        FENCE_ITEM = "牵牛延蔓绕篱笆！",		-- 物品名:"木栅栏" 制造描述:"木栅栏部分"
        FENCE_GATE = "小门",		-- 物品名:"木门"
        FENCE_GATE_ITEM = "建小门的材料",		-- 物品名:"木门" 制造描述:"木栅栏的门"
		WALRUS = "海象先生，帽子可以借我戴戴吗？",		-- 物品名:"海象人"
		WALRUSHAT = "海象先生去哪里了呢",		-- 物品名:"海象的贝雷帽"
		WALRUS_CAMP =
		{
			EMPTY = "海象巢穴？",		-- 物品名:"海象营"
			GENERIC = "虽然是冰做的房子，但是看起来很暖和",		-- 物品名:"海象营"->默认
		},
		WALRUS_TUSK = "吃剩的海象！",		-- 物品名:"海象牙"
		WARDROBE = 
		{
			GENERIC = "衣服永远都是不够的",		-- 物品名:"衣柜"->默认 制造描述:"随心变换面容"
            BURNING = "我的衣服！！",		-- 物品名:"衣柜"->正在燃烧 制造描述:"随心变换面容"
			BURNT = "需要赶紧复原",		-- 物品名:"衣柜"->烧焦的 制造描述:"随心变换面容"
		},
		WARG = "硬币的妈妈",		-- 物品名:"座狼"
		WASPHIVE = "需要使用火牌了嘛。",		-- 物品名:"杀人蜂蜂窝"
		WATERBALLOON = "我已经过了那个年纪了",		-- 物品名:"水球" 制造描述:"球体灭火"
		WATERMELON = "好吃！",		-- 物品名:"西瓜"
		WATERMELON_COOKED = "呜，没有味了",		-- 物品名:"烤西瓜"
		WATERMELONHAT = "给非猪戴吧，我可不要！",		-- 物品名:"西瓜帽" 制造描述:"提神醒脑，但感觉黏黏的"
		WAXWELLJOURNAL = "这是一个故事",		-- 物品名:"暗影魔法书" 制造描述:"这将让你大吃一惊"
		WETGOOP = "屎竟然是烹饪出来的",		-- 物品名:"失败料理"
        WHIP = "是不是有什么不好的联想？",		-- 物品名:"皮鞭" 制造描述:"提出有建设性的反馈意见"
		WINTERHAT = "暖和的帽子",		-- 物品名:"冬帽" 制造描述:"保持脑袋温暖"
		WINTEROMETER = 
		{
			GENERIC = "气温测量",		-- 物品名:"温度测量仪"->默认 制造描述:"测量环境气温"
			BURNT = "显示不出东西了",		-- 物品名:"温度测量仪"->烧焦的 制造描述:"测量环境气温"
		},
        WINTER_TREE =
        {
            BURNT = "只剩炭了",		-- 物品名:"冬季圣诞树"->烧焦的
            BURNING = "雨来！",		-- 物品名:"冬季圣诞树"->正在燃烧
            CANDECORATE = "圣诞节快到了？",		-- 物品名:"冬季圣诞树"->烛台？？？
            YOUNG = "需要点催生！",		-- 物品名:"冬季圣诞树"->还年轻
        },
		WINTER_TREESTAND = 
		{
			GENERIC = "需要树的种子",		-- 物品名:"圣诞树墩"->默认 制造描述:"种植并装饰一棵冬季圣诞树！"
            BURNT = "只剩焦炭了",		-- 物品名:"圣诞树墩"->烧焦的 制造描述:"种植并装饰一棵冬季圣诞树！"
		},
        WINTER_ORNAMENT = "可爱的小饰品",		-- 物品名:"圣诞小玩意"
        WINTER_ORNAMENTLIGHT = "照亮黑暗！",		-- 物品名:"圣诞灯"
        WINTER_ORNAMENTBOSS = "值钱的装饰品",		-- 物品名:"华丽的装饰"
		WINTER_ORNAMENTFORGE = "奇特的装饰",		-- 物品名:"熔炉装饰"
		WINTER_ORNAMENTGORGE = "……？",		-- 物品名:"舒缓的装饰"
        WINTER_FOOD1 = "奇妙的味道", --gingerbread cookie		-- 物品名:"小姜饼"
        WINTER_FOOD2 = "下午茶时间到了", --sugar cookie		-- 物品名:"糖曲奇饼"
        WINTER_FOOD3 = "脆的！", --candy cane		-- 物品名:"拐杖糖"
        WINTER_FOOD4 = "好吃！", --fruitcake		-- 物品名:"永远的水果蛋糕"
        WINTER_FOOD5 = "有点小", --yule log cake		-- 物品名:"巧克力树洞蛋糕"
        WINTER_FOOD6 = "还能来点吗？", --plum pudding		-- 物品名:"李子布丁"
        WINTER_FOOD7 = "我有故事，你有酒吗？", --apple cider		-- 物品名:"苹果酒"
        WINTER_FOOD8 = "身心都暖和了", --hot cocoa		-- 物品名:"热可可"
        WINTER_FOOD9 = "清甜可口！", --eggnog		-- 物品名:"美味的蛋酒"
		WINTERSFEASTOVEN =
		{
			GENERIC = "做面包吧",		-- 物品名:"砖砌烤炉"->默认 制造描述:"燃起了喜庆的火焰"
			COOKING = "快要好了",		-- 物品名:"砖砌烤炉" 制造描述:"燃起了喜庆的火焰"
			ALMOST_DONE_COOKING = "差不多了吧？",		-- 物品名:"砖砌烤炉" 制造描述:"燃起了喜庆的火焰"
			DISH_READY = "出炉了！",		-- 物品名:"砖砌烤炉" 制造描述:"燃起了喜庆的火焰"
		},
		BERRYSAUCE = "美味的浆果！",		-- 物品名:"快乐浆果酱"
		BIBINGKA = "呜，太好吃了！",		-- 物品名:"比宾卡米糕"
		CABBAGEROLLS = "甜甜的！",		-- 物品名:"白菜卷"
		FESTIVEFISH = "有点独特的味道！",		-- 物品名:"节庆鱼料理"
		GRAVY = "有营养的汤！",		-- 物品名:"好肉汁"
		LATKES = "香脆美味！",		-- 物品名:"土豆饼"
		LUTEFISK = "新料理！",		-- 物品名:"苏打鱼"
		MULLEDDRINK = "小孩子不能喝酒！！",		-- 物品名:"香料潘趣酒"
		PANETTONE = "果然新出炉的面包最棒！",		-- 物品名:"托尼甜面包"
		PAVLOVA = "黏滑的口感",		-- 物品名:"巴甫洛娃蛋糕"
		PICKLEDHERRING = "腌制起来的东西也不错！",		-- 物品名:"腌鲱鱼"
		POLISHCOOKIE = "可口的零食！",		-- 物品名:"波兰饼干"
		PUMPKINPIE = "香甜的味道！",		-- 物品名:"南瓜饼"
		ROASTTURKEY = "感恩节料理？",		-- 物品名:"烤火鸡"
		STUFFING = "好像有点重口味？",		-- 物品名:"烤火鸡面包馅"
		SWEETPOTATO = "清香的米饭太棒了！",		-- 物品名:"红薯焗饭"
		TAMALES = "这个披萨吗？",		-- 物品名:"塔马利"
		TOURTIERE = "有点辣了！",		-- 物品名:"饕餮馅饼"
		TABLE_WINTERS_FEAST = 
		{
			GENERIC = "可以大吃一顿了！",		-- 物品名:"冬季盛宴餐桌"->默认 制造描述:"一起来享用冬季盛宴吧"
			HAS_FOOD = "料理准备好了",		-- 物品名:"冬季盛宴餐桌" 制造描述:"一起来享用冬季盛宴吧"
			WRONG_TYPE = "这不是可以端上餐桌的东西",		-- 物品名:"冬季盛宴餐桌" 制造描述:"一起来享用冬季盛宴吧"
			BURNT = "晚饭！",		-- 物品名:"冬季盛宴餐桌"->烧焦的 制造描述:"一起来享用冬季盛宴吧"
		},
		GINGERBREADWARG = "点心做的狼？！", 		-- 物品名:"姜饼狼"
		GINGERBREADHOUSE = "我要进去啦？", 		-- 物品名:"姜饼猪屋"
		GINGERBREADPIG = "总是要填饱肚子的吧",		-- 物品名:"姜饼猪"
		CRUMBS = "吃剩的饼干",		-- 物品名:"饼干屑"
		WINTERSFEASTFUEL = "里面有魔法的气息",		-- 物品名:"节日欢愉"
        KLAUS = "看上去似乎不好惹",		-- 物品名:"克劳斯"
        KLAUS_SACK = "这是我的了！",		-- 物品名:"赃物袋"
		KLAUSSACKKEY = "财宝袋的钥匙到手啦！",		-- 物品名:"麋鹿茸"
		WORMHOLE =
		{
			GENERIC = "队友跳进去就可以打包队友了",		-- 物品名:"虫洞"->默认
			OPEN = "里面通向哪里呢？",		-- 物品名:"虫洞"->打开
		},
		WORMHOLE_LIMITED = "损坏的通道",		-- 物品名:"生病的虫洞"->一次性虫洞 单机
		ACCOMPLISHMENT_SHRINE = "我能摸摸你的奖杯吗",        		-- 物品名:"奖杯" 制造描述:"证明你作为一个人的价值"
		LIVINGTREE = "这颗树长的好奇怪！",		-- 物品名:"完全正常的树"
		ICESTAFF = "带点冰魔法的法杖",		-- 物品名:"冰魔杖" 制造描述:"把敌人冰冻在原地"
		REVIVER = "可以让笨比复活",		-- 物品名:"告密的心" 制造描述:"鬼魂朋友复活了，好可怕"
		SHADOWHEART = "好东西，虽然没什么用",		-- 物品名:"暗影心房"
        ATRIUM_RUBBLE ={ 
        
			LINE_1 = "从前有座山",		-- 物品名:"古代的壁画"->第一行
			LINE_2 = "山里有座庙",		-- 物品名:"古代的壁画"->第二行
			LINE_3 = "庙里有个小和尚",		-- 物品名:"古代的壁画"->第三行
			LINE_4 = "老和尚给小和尚讲故事",		-- 物品名:"古代的壁画"->第四行
			LINE_5 = "他说：",		-- 物品名:"古代的壁画"->第五行
		},
        ATRIUM_STATUE = "古代的虫子？",		-- 物品名:"远古雕像"
        ATRIUM_LIGHT = 
        {
			ON = "不祥气息!",		-- 物品名:"古代的灯塔"->开启
			OFF = "需要什么材料呢",		-- 物品名:"古代的灯塔"->关闭
		},
        ATRIUM_GATE =
        {
			ON = "新的通道！",		-- 物品名:"古代的通道"->开启
			OFF = "需要修复一下吗",		-- 物品名:"古代的通道"->关闭
			CHARGING = "要开启吗",		-- 物品名:"古代的通道"->充能中
			DESTABILIZING = "出了什么问题了？",		-- 物品名:"古代的通道"->不稳定
			COOLDOWN = "需要一段时间",		-- 物品名:"古代的通道"->冷却中
        },
        ATRIUM_KEY = "臭臭的？！",		-- 物品名:"古代的钥匙"
		LIFEINJECTOR = "大便注射针？",		-- 物品名:"强心针" 制造描述:"提高下你那日渐衰退的最大健康值吧"
		SKELETON_PLAYER =
		{
			MALE = "你是真人吗",		-- 物品名:"骷髅"->男性
			FEMALE = "你是真人吗",		-- 物品名:"骷髅"->女性
			ROBOT = "你是，你还真不是真人？",		-- 物品名:"骷髅"->机器人
			DEFAULT = "再见……",		-- 物品名:"物品栏物品"->默认
		},
		HUMANMEAT = "这是猪比的肉吗？？？？",		-- 物品名:"长猪"
		HUMANMEAT_COOKED = "转人工？",		-- 物品名:"煮熟的长猪"
		HUMANMEAT_DRIED = "晒干的猪比肉",		-- 物品名:"长猪肉干"
		ROCK_MOON = "凿开里面会有好东西吧",		-- 物品名:"岩石"
		MOONROCKNUGGET = "月亮上的石头",		-- 物品名:"月岩"
		MOONROCKCRATER = "还需要一颗各色魔法石！",		-- 物品名:"有洞的月亮石" 制造描述:"用于划定地盘的岩石"
		MOONROCKSEED = "手握日月摘星辰，就是我啦！",		-- 物品名:"天体宝球"
        REDMOONEYE = "深红之光",		-- 物品名:"红色月眼"
        PURPLEMOONEYE = "紫色之光",		-- 物品名:"紫色月眼"
        GREENMOONEYE = "复苏之心",		-- 物品名:"绿色月眼"
        ORANGEMOONEYE = "橙色之光",		-- 物品名:"橘色月眼"
        YELLOWMOONEYE = "闪耀太星",		-- 物品名:"黄色月眼"
        BLUEMOONEYE = "蓝色结点",		-- 物品名:"蓝色月眼"
        BOARRIOR = "强大的兽人",		-- 物品名:"大熔炉猪战士"->大熔炉猪战士
        BOARON = "你想挑衅魔女的威严吗？",		-- 物品名:"小猪"
        PEGHOOK = "我讨厌虫子！",		-- 物品名:"蝎子"
        TRAILS = "看上去很结实的样子",		-- 物品名:"大猩猩"
        TURTILLUS = "王八？",		-- 物品名:"坦克龟"
        SNAPPER = "头领就是它吗？",		-- 物品名:"鳄鱼指挥官"
		RHINODRILL = "可不能被撞到了！",		-- 物品名:"后扣帽犀牛兄弟"
		BEETLETAUR = "值得一战的对手",		-- 物品名:"地狱独眼巨猪"
        LAVAARENA_PORTAL = 
        {
            ON = "踏上新的旅程！",		-- 物品名:"远古传送门"->开启
            GENERIC = "这是，传送门？",		-- 物品名:"远古传送门"->默认
        },
        HEALINGSTAFF = "带点复苏魔法的法杖",		-- 物品名:"生存魔杖"
        FIREBALLSTAFF = "陨星法杖？",		-- 物品名:"地狱魔杖"
        HAMMER_MJOLNIR = "精致的锤子！",		-- 物品名:"锻锤"
        SPEAR_GUNGNIR = "还是法杖更适合我！",		-- 物品名:"尖齿矛"
        BLOWDART_LAVA = "暗杀道具？",		-- 物品名:"吹箭"
        BLOWDART_LAVA2 = "上面附加了魔法！",		-- 物品名:"熔化吹箭"
        WEBBER_SPIDER_MINION = "离我远点！",		-- 物品名:"蜘蛛宝宝"
        BOOK_FOSSIL = "美杜莎的气息",		-- 物品名:"石化之书"
		SPEAR_LANCE = "看上去冲击力很强",		-- 物品名:"螺旋矛"
		BOOK_ELEMENTAL = "召唤魔法书？",		-- 物品名:"召唤之书"
        QUAGMIRE_ALTAR = 
        {
        	GENERIC = "吞噬怪物的气息",		-- 物品名:"饕餮祭坛"->默认
        	FULL = "快住口！",		-- 物品名:"饕餮祭坛"->满了
    	},
		QUAGMIRE_SUGARWOODTREE = 
		{
			GENERIC = "甜的树？！",		-- 物品名:"糖木树"->默认
			STUMP = "还会长出来吗？",		-- 物品名:"糖木树"->暴食模式糖木树只剩树桩了
			TAPPED_EMPTY = "不是我干的！",		-- 物品名:"糖木树"->暴食模式糖木树空了
			TAPPED_READY = "树在结它的种子！",		-- 物品名:"糖木树"->暴食模式糖木树好了
			TAPPED_BUGS = "呜，我可受不了这些",		-- 物品名:"糖木树"->暴食模式糖木树上有蚂蚁
			WOUNDED = "要治好它吗？",		-- 物品名:"糖木树"->暴食糖木树生病了
		},
		QUAGMIRE_SPOTSPICE_SHRUB = 
		{
			GENERIC = "蕨类植物？",		-- 物品名:"带斑点的小灌木"->默认
			PICKED = "需要点催生魔法",		-- 物品名:"带斑点的小灌木"->被采完了
		},
		QUAGMIRE_SALT_RACK =
		{
			READY = "这下有盐了！",		-- 物品名:"盐架"->准备好的 满的
			GENERIC = "盐分提取装置，不愧是我！",		-- 物品名:"盐架"->默认
		},
		QUAGMIRE_SAFE = 
		{
			GENERIC = "没人的话我可打开了啊",		-- 物品名:"保险箱"->默认
			LOCKED = "需要点开锁魔法",		-- 物品名:"保险箱"->锁住了
		},
		QUAGMIRE_MUSHROOMSTUMP =
		{
			GENERIC = "可怕的东西！",		-- 物品名:"蘑菇"->默认
			PICKED = "不用见到真是太好了",		-- 物品名:"蘑菇"->被采完了
		},
        QUAGMIRE_RUBBLE_HOUSE =
        {
            "你好？",		-- 物品名:"残破的房子" 制造描述:未找到
            "这里好荒凉",		-- 物品名:"残破的房子" 制造描述:未找到
            "家里没人",		-- 物品名:"残破的房子" 制造描述:未找到
        },
        QUAGMIRE_SWAMPIGELDER =
        {
            GENERIC = "沼泽的兽人？",		-- 物品名:"沼泽猪长老"->默认
            SLEEPING = "有什么东西可以拿走吗？",		-- 物品名:"沼泽猪长老"->睡着了
        },
        QUAGMIRE_FOOD =
        {
        	GENERIC = "该把它给天上的大嘴！",		-- 物品名:未找到
            MISMATCH = "它应该不会喜欢",		-- 物品名:未找到
            MATCH = "适合天上的嘴巴！",		-- 物品名:未找到
            MATCH_BUT_SNACK = "嘴巴这么大，食物比起来真小",		-- 物品名:未找到
        },
        QUAGMIRE_PARK_GATE =
        {
            GENERIC = "那我进去啦",		-- 物品名:"铁门"->默认
            LOCKED = "我能进去吗？不太好吧？但是，我进去啦",		-- 物品名:"铁门"->锁住了
        },
        QUAGMIRE_PIGEON =
        {
            DEAD = "总是要填饱肚子吧",		-- 物品名:"鸽子"->死了 制造描述:"这是一只完整的活鸽"
            GENERIC = "被我逮住了吧",		-- 物品名:"鸽子"->默认 制造描述:"这是一只完整的活鸽"
            SLEEPING = "咕咕咕？",		-- 物品名:"鸽子"->睡着了 制造描述:"这是一只完整的活鸽"
        },
        WINONA_CATAPULT = 
        {
        	GENERIC = "简朴的工具",		-- 物品名:"薇诺娜的投石机"->默认 制造描述:"向敌人投掷大石块"
        	OFF = "需要点启动材料？",		-- 物品名:"薇诺娜的投石机"->关闭 制造描述:"向敌人投掷大石块"
        	BURNING = "投石机！",		-- 物品名:"薇诺娜的投石机"->正在燃烧 制造描述:"向敌人投掷大石块"
        	BURNT = "让我看看复原魔法行不行？",		-- 物品名:"薇诺娜的投石机"->烧焦的 制造描述:"向敌人投掷大石块"
        },
        WINONA_SPOTLIGHT = 
        {
        	GENERIC = "世界以我聚焦！",		-- 物品名:"薇诺娜的聚光灯"->默认 制造描述:"白天夜里都发光"
        	OFF = "需要补充点电力了",		-- 物品名:"薇诺娜的聚光灯"->关闭 制造描述:"白天夜里都发光"
        	BURNING = "聚光灯！",		-- 物品名:"薇诺娜的聚光灯"->正在燃烧 制造描述:"白天夜里都发光"
        	BURNT = "让我看看复原魔法行不行？",		-- 物品名:"薇诺娜的聚光灯"->烧焦的 制造描述:"白天夜里都发光"
        },
        WINONA_BATTERY_LOW = 
        {
        	GENERIC = "供电箱",		-- 物品名:"薇诺娜的发电机"->默认 制造描述:"要确保电力供应充足"
        	LOWPOWER = "需要补充点电力了",		-- 物品名:"薇诺娜的发电机"->没电了 制造描述:"要确保电力供应充足"
        	OFF = "启动开关在哪来着？",		-- 物品名:"薇诺娜的发电机"->关闭 制造描述:"要确保电力供应充足"
        	BURNING = "我的便利道具！",		-- 物品名:"薇诺娜的发电机"->正在燃烧 制造描述:"要确保电力供应充足"
        	BURNT = "让我看看复原魔法行不行？",		-- 物品名:"薇诺娜的发电机"->烧焦的 制造描述:"要确保电力供应充足"
        },
        WINONA_BATTERY_HIGH = 
        {
        	GENERIC = "昂贵的机器！",		-- 物品名:"薇诺娜的宝石发电机"->默认 制造描述:"这玩意烧宝石，所以肯定不会差"
        	LOWPOWER = "要补充宝石吗？",		-- 物品名:"薇诺娜的宝石发电机"->没电了 制造描述:"这玩意烧宝石，所以肯定不会差"
        	OFF = "启动开关在哪来着？",		-- 物品名:"薇诺娜的宝石发电机"->关闭 制造描述:"这玩意烧宝石，所以肯定不会差"
        	BURNING = "我花了一大笔钱的！",		-- 物品名:"薇诺娜的宝石发电机"->正在燃烧 制造描述:"这玩意烧宝石，所以肯定不会差"
        	BURNT = "让我看看复原魔法行不行？",		-- 物品名:"薇诺娜的宝石发电机"->烧焦的 制造描述:"这玩意烧宝石，所以肯定不会差"
        },
        COMPOSTWRAP = "植物养料",		-- 物品名:"肥料包" 制造描述:"\"草本\"的疗法"
        ARMOR_BRAMBLE = "荆棘的外壳",		-- 物品名:"荆棘外壳" 制造描述:"让大自然告诉你什么叫\"滚开\""
        TRAP_BRAMBLE = "来自植物的陷阱！",		-- 物品名:"荆棘陷阱" 制造描述:"都有机会中招的干\n扰陷阱"
        BOATFRAGMENT03 = "还是扫把便利！",		-- 物品名:"船碎片"
        BOATFRAGMENT04 = "还是扫把便利！",		-- 物品名:"船碎片"
        BOATFRAGMENT05 = "还是扫把便利！",		-- 物品名:"船碎片"
		BOAT_LEAK = "我想去天上看看",		-- 物品名:"漏洞"
        MAST = "要利用风的力量",		-- 物品名:"桅杆" 制造描述:"乘风破浪会有时"
        SEASTACK = "石堆",		-- 物品名:"浮堆"
        FISHINGNET = "要去捕鱼吗？",		-- 物品名:"渔网" 制造描述:"就是一张网"
        ANTCHOVIES = "希望味道好",		-- 物品名:"蚁头凤尾鱼"
        STEERINGWHEEL = "风，为我所用吧",		-- 物品名:"方向舵" 制造描述:"航海必备道具"
        ANCHOR = "给我停住",		-- 物品名:"锚" 制造描述:"船用刹车"
        BOATPATCH = "船破了，救救！！",		-- 物品名:"船补丁" 制造描述:"打补丁永远不晚"
        DRIFTWOOD_TREE = 
        {
            BURNING = "薪尽火传！",		-- 物品名:"浮木"->正在燃烧
            BURNT = "烧光了",		-- 物品名:"浮木"->烧焦的
            CHOPPED = "腐朽气息！",		-- 物品名:"浮木"->被砍了
            GENERIC = "从哪漂来的",		-- 物品名:"浮木"->默认
        },
        DRIFTWOOD_LOG = "海上的浮木",		-- 物品名:"浮木桩"
        MOON_TREE = 
        {
            BURNING = "薪尽火传",		-- 物品名:"月树"->正在燃烧
            BURNT = "烧光了",		-- 物品名:"月树"->烧焦的
            CHOPPED = "还会长出来吗？",		-- 物品名:"月树"->被砍了
            GENERIC = "有魔力的树",		-- 物品名:"月树"->默认
        },
		MOON_TREE_BLOSSOM = "配上伊蕾娜的可爱吗？",		-- 物品名:"月树花"
        MOONBUTTERFLY = 
        {
        	GENERIC = "蝶舞蹁跹",		-- 物品名:"月蛾"->默认
        	HELD = "化蝶",		-- 物品名:"月蛾"->拿在手里
        },
		MOONBUTTERFLYWINGS = "新的魔法材料",		-- 物品名:"月蛾翅膀"
        MOONBUTTERFLY_SAPLING = "生生不息",		-- 物品名:"月树苗"
        ROCK_AVOCADO_FRUIT = "这是石头里的果子吧？",		-- 物品名:"石果"
        ROCK_AVOCADO_FRUIT_RIPE = "炸出来吃吧",		-- 物品名:"成熟石果"
        ROCK_AVOCADO_FRUIT_RIPE_COOKED = "没有烤的必要！",		-- 物品名:"熟石果"
        ROCK_AVOCADO_FRUIT_SPROUT = "我看看怎么用催生魔法",		-- 物品名:"发芽的石果"
        ROCK_AVOCADO_BUSH = 
        {
        	BARREN = "这是果树？",		-- 物品名:"石果灌木丛"
			WITHERED = "我看看怎么用降雨魔法",		-- 物品名:"石果灌木丛"->枯萎了
			GENERIC = "石头的生命",		-- 物品名:"石果灌木丛"->默认
			PICKED = "还差些火候！",		-- 物品名:"石果灌木丛"->被采完了
			DISEASED = "要治好它吗？",		-- 物品名:"石果灌木丛"->生病了
            DISEASING = "它在腐朽！",		-- 物品名:"石果灌木丛"->正在生病？？
			BURNING = "石头也会燃烧？？",		-- 物品名:"石果灌木丛"->正在燃烧
		},
        DEAD_SEA_BONES = "骸骨",		-- 物品名:"海骨"
        HOTSPRING = 
        {
        	GENERIC = "清泉水上流！",		-- 物品名:"温泉"->默认
        	BOMBED = "可以泡澡了",		-- 物品名:"温泉"
        	GLASS = "清泉水上流！",		-- 物品名:"温泉"
			EMPTY = "清泉水上流！",		-- 物品名:"温泉"
        },
        MOONGLASS = "变异的月亮石",		-- 物品名:"月亮碎片"
        MOONGLASS_ROCK = "好看的玻璃",		-- 物品名:"月光玻璃"
        BATHBOMB = "沐浴球！",		-- 物品名:"沐浴球" 制造描述:"春天里来百花香？这点子把地都炸碎了"
        TRAP_STARFISH =
        {
            GENERIC = "陷阱！！",		-- 物品名:"海星"->默认
            CLOSED = "可以利用",		-- 物品名:"海星"
        },
        DUG_TRAP_STARFISH = "放哪里呢？",		-- 物品名:"海星陷阱"
        SPIDER_MOON = 
        {
        	GENERIC = "变异虫子",		-- 物品名:"破碎蜘蛛"->默认
        	SLEEPING = "趁黑下手",		-- 物品名:"破碎蜘蛛"->睡着了
        	DEAD = "挑错了对手！",		-- 物品名:"破碎蜘蛛"->死了
        },
        MOONSPIDERDEN = "虫子巢穴",		-- 物品名:"破碎蜘蛛洞"
		FRUITDRAGON =
		{
			GENERIC = "这是活的叶肉？",		-- 物品名:"沙拉蝾螈"->默认
			RIPE = "这是活的火龙果？",		-- 物品名:"沙拉蝾螈"
			SLEEPING = "我大哥睡醒就要杀人！",		-- 物品名:"沙拉蝾螈"->睡着了
		},
        PUFFIN =
        {
            GENERIC = "来跟着我念，我很可爱请给我钱！",		-- 物品名:"海鹦鹉"->默认
            HELD = "逮住你了！",		-- 物品名:"海鹦鹉"->拿在手里
            SLEEPING = "好懒",		-- 物品名:"海鹦鹉"->睡着了
        },
		MOONGLASSAXE = "魔法石做的斧头！",		-- 物品名:"月光玻璃斧" 制造描述:"脆弱而有效"
		GLASSCUTTER = "精致且优雅！",		-- 物品名:"玻璃刀" 制造描述:"尖端武器"
        ICEBERG =
        {
            GENERIC = "冰魔法！",		-- 物品名:"小冰山"->默认
            MELTED = "冰魔法",		-- 物品名:"小冰山"->融化了
        },
        ICEBERG_MELTED = "使用冰魔法的痕迹",		-- 物品名:"融化的冰山"
        MINIFLARE = "希望巨鹿能看见",		-- 物品名:"信号" 制造描述:"为你信任的朋友照亮前路"
		MOON_FISSURE = 
		{
			GENERIC = "充满魔力的裂缝", 		-- 物品名:"天体裂隙"->默认
			NOLIGHT = "这里连何处？",		-- 物品名:"天体裂隙"
		},
        MOON_ALTAR =
        {
            MOON_ALTAR_WIP = "还需要点东西",		-- 物品名:未找到
            GENERIC = "需要帮忙吗？",		-- 物品名:未找到
        },
        MOON_ALTAR_IDOL = "复合魔法的组成材料",		-- 物品名:"天体祭坛雕像"
        MOON_ALTAR_GLASS = "复合魔法的组成材料",		-- 物品名:"天体祭坛底座"
        MOON_ALTAR_SEED = "复合魔法的组成材料",		-- 物品名:"天体祭坛宝球"
        MOON_ALTAR_ROCK_IDOL = "你好吗？",		-- 物品名:"在呼唤我"
        MOON_ALTAR_ROCK_GLASS = "你好吗？",		-- 物品名:"在呼唤我"
        MOON_ALTAR_ROCK_SEED = "你好吗？",		-- 物品名:"在呼唤我"
        SEAFARING_PROTOTYPER =
        {
            GENERIC = "新的技术！",		-- 物品名:"智囊团"->默认 制造描述:"海上科学"
            BURNT = "消失的魔力回路",		-- 物品名:"智囊团"->烧焦的 制造描述:"海上科学"
        },
        BOAT_ITEM = "扫把更方便？",		-- 物品名:"船套装" 制造描述:"让大海成为你的领地"
        STEERINGWHEEL_ITEM = "引导风的方向",		-- 物品名:"方向舵套装" 制造描述:"航海必备道具"
        ANCHOR_ITEM = "固定船的工具",		-- 物品名:"锚套装" 制造描述:"船用刹车"
        MAST_ITEM = "能利用风的力量",		-- 物品名:"桅杆套装" 制造描述:"乘风破浪会有时"
        MUTATEDHOUND = 
        {
        	DEAD = "挑错了对手！",		-- 物品名:"恐怖猎犬"->死了
        	GENERIC = "可以再死一次哦",		-- 物品名:"恐怖猎犬"->默认
        	SLEEPING = "尸体也会睡觉嘛？",		-- 物品名:"恐怖猎犬"->睡着了
        },
        MUTATED_PENGUIN = 
        {
			DEAD = "挑错了对手！",		-- 物品名:"月石企鸥"->死了
			GENERIC = "被侵蚀的鸟",		-- 物品名:"月石企鸥"->默认
			SLEEPING = "要净化它们吗？",		-- 物品名:"月石企鸥"->睡着了
		},
        CARRAT = 
        {
        	DEAD = "失去魔力躯体",		-- 物品名:"胡萝卜"->死了 制造描述:"灵巧机敏，富含胡萝卜素"
        	GENERIC = "胡萝卜鼠？",		-- 物品名:"胡萝卜"->默认 制造描述:"灵巧机敏，富含胡萝卜素"
        	HELD = "兔兔的食物成精了",		-- 物品名:"胡萝卜"->拿在手里 制造描述:"灵巧机敏，富含胡萝卜素"
        	SLEEPING = "它在吸取大地的养分",		-- 物品名:"胡萝卜"->睡着了 制造描述:"灵巧机敏，富含胡萝卜素"
        },
		BULLKELP_PLANT = 
        {
            GENERIC = "海带！！",		-- 物品名:"公牛海带"->默认
            PICKED = "还差点",		-- 物品名:"公牛海带"->被采完了
        },
		BULLKELP_ROOT = "可以多种点",		-- 物品名:"公牛海带茎"
        KELPHAT = "我的头上已经有她送的帽子了",		-- 物品名:"海花冠" 制造描述:"让人神经焦虑的东西"
		KELP = "海带！",		-- 物品名:"海带叶"
		KELP_COOKED = "没有烤的必要！",		-- 物品名:"熟海带叶"
		KELP_DRIED = "可以卖钱",		-- 物品名:"干海带叶"
		GESTALT = "潜伏的暗影",		-- 物品名:"虚空之影"
		COOKIECUTTER = "不喜欢虫子",		-- 物品名:"饼干切割机"
		COOKIECUTTERSHELL = "这个能做什么？",		-- 物品名:"饼干切割机壳"
		COOKIECUTTERHAT = "我的头上已经有她送的帽子了！",		-- 物品名:"饼干切割机帽子" 制造描述:"穿着必须犀利"
		SALTSTACK =
		{
			GENERIC = "盐晶石！",		-- 物品名:"盐堆"->默认
			MINED_OUT = "还差点火候",		-- 物品名:"盐堆"
			GROWING = "快好了吧！",		-- 物品名:"盐堆"->正在生长
		},
		SALTROCK = "新的调味料！",		-- 物品名:"盐晶"
		SALTBOX = "腌制食品储存箱",		-- 物品名:"盐盒" 制造描述:"用盐来储存食物"
		TACKLESTATION = "一点新玩意!",		-- 物品名:"钓具容器" 制造描述:"传统的用饵钓鱼"
		TACKLESKETCH = "是宣传我美貌的海报吗？",		-- 物品名:"{item}广告"
        MALBATROSS = "邪天翁先生，可以借我一根桨吗？",		-- 物品名:"邪天翁"
        MALBATROSS_FEATHER = "漂亮的羽毛",		-- 物品名:"邪天翁羽毛"
        MALBATROSS_BEAK = "邪天翁先生说不用还了！",		-- 物品名:"邪天翁喙"
        MAST_MALBATROSS_ITEM = "风力牵引！",		-- 物品名:"飞翼风帆套装" 制造描述:"像海鸟一样航向深蓝"
        MAST_MALBATROSS = "去利用风的力量吧！",		-- 物品名:"飞翼风帆" 制造描述:"像海鸟一样航向深蓝"
		MALBATROSS_FEATHERED_WEAVE = "蓝色的布料！",		-- 物品名:"羽毛帆布" 制造描述:"精美的羽毛布料"
        GNARWAIL =
        {
            GENERIC = "这角？",		-- 物品名:"一角鲸"->默认
            BROKENHORN = "遭受袭击了吗？",		-- 物品名:"一角鲸"
            FOLLOWER = "做我一段时间的宠物吧",		-- 物品名:"一角鲸"->追随者
            BROKENHORN_FOLLOWER = "遭受了袭击吗？",		-- 物品名:"一角鲸"
        },
        GNARWAIL_HORN = "可以用来合成魔法道具",		-- 物品名:"一角鲸的角"
        WALKINGPLANK = "长宽刚好合适",		-- 物品名:"木板"
        OAR = "还要我动手吗？",		-- 物品名:"桨" 制造描述:"划，划，划小船"
		OAR_DRIFTWOOD = "还要我动手吗？",		-- 物品名:"浮木桨" 制造描述:"小桨要用浮木造？"
		OCEANFISHINGROD = "愿者上钩！",		-- 物品名:"海钓竿" 制造描述:"像职业选手一样钓鱼吧"
		OCEANFISHINGBOBBER_NONE = "差点什么",		-- 物品名:"鱼钩"
        OCEANFISHINGBOBBER_BALL = "这下能钓更远的鱼了",		-- 物品名:"木球浮标" 制造描述:"经典设计，初学者和职业钓手两相宜"
        OCEANFISHINGBOBBER_OVAL = "这下能钓更远的鱼了",		-- 物品名:"硬物浮标" 制造描述:"在经典浮标的基础上融入了时尚设计"
		OCEANFISHINGBOBBER_CROW = "这就是专业吗？",		-- 物品名:"黑羽浮标" 制造描述:"深受职业钓手的喜爱"
		OCEANFISHINGBOBBER_ROBIN = "这就是专业吗？",		-- 物品名:"红羽浮标" 制造描述:"深受职业钓手的喜爱"
		OCEANFISHINGBOBBER_ROBIN_WINTER = "这就是专业吗？",		-- 物品名:"蔚蓝羽浮标" 制造描述:"深受职业钓手的喜爱"
		OCEANFISHINGBOBBER_CANARY = "这就是专业吗？",		-- 物品名:"番红花羽浮标" 制造描述:"深受职业钓手的喜爱"
		OCEANFISHINGBOBBER_GOOSE = "这就是专业吗？",		-- 物品名:"鹅羽浮标" 制造描述:"高级羽绒浮标"
		OCEANFISHINGBOBBER_MALBATROSS = "这就是专业吗？",		-- 物品名:"邪天翁羽浮标" 制造描述:"高级巨鸟浮标"
		OCEANFISHINGLURE_SPINNER_RED = "早起的鱼儿被我吃！",		-- 物品名:"日出旋转亮片" 制造描述:"早起的鱼儿有虫吃"
		OCEANFISHINGLURE_SPINNER_GREEN = "就差一道鱼汤了",		-- 物品名:"黄昏旋转亮片" 制造描述:"低光照环境里效果最好"
		OCEANFISHINGLURE_SPINNER_BLUE = "我可以去睡觉了吗？",		-- 物品名:"夜飞侠旋转亮片" 制造描述:"适用于夜间垂钓"
		OCEANFISHINGLURE_SPOON_RED = "早起的鱼儿被我吃！",		-- 物品名:"日出匙型假饵" 制造描述:"早起的鱼儿有虫吃"
		OCEANFISHINGLURE_SPOON_GREEN = "就差一道鱼汤了",		-- 物品名:"黄昏匙型假饵" 制造描述:"在夕阳中继续垂钓"
		OCEANFISHINGLURE_SPOON_BLUE = "我可以去睡觉了吗？",		-- 物品名:"匙型假饵" 制造描述:"适用于夜间垂钓"
		OCEANFISH_SMALL_1 = "它的屏呢？",		-- 物品名:"小孔雀鱼"
		OCEANFISH_SMALL_2 = "不是很好看",		-- 物品名:"针鼻喷墨鱼"
		OCEANFISH_SMALL_3 = "肉太少了",		-- 物品名:"小饵鱼"
		OCEANFISH_SMALL_4 = "肉太少了",		-- 物品名:"三文鱼苗"
		OCEANFISH_SMALL_5 = "零食做的鱼？",		-- 物品名:"爆米花鱼"
		OCEANFISH_MEDIUM_1 = "这鱼分量很足",		-- 物品名:"泥鱼"
		OCEANFISH_MEDIUM_2 = "没见过的品种",		-- 物品名:"斑鱼"
		OCEANFISH_MEDIUM_3 = "夸张只因为害怕？",		-- 物品名:"浮夸狮子鱼"
		OCEANFISH_MEDIUM_4 = "应该会很美味吧？",		-- 物品名:"黑鲶鱼"
		OCEANFISH_MEDIUM_5 = "植物鱼？",		-- 物品名:"玉米鳕鱼"
		OCEANFISH_MEDIUM_6 = "鱼缸能派上用场了",		-- 物品名:"花锦鲤"
		OCEANFISH_MEDIUM_7 = "这能值不少钱吧！",		-- 物品名:"金锦鲤"
		PONDFISH = "一条小鱼！",		-- 物品名:"淡水鱼"
		PONDEEL = "今晚吃鳗鱼饭吧！",		-- 物品名:"鳗鱼"
        FISHMEAT = "太小了！",		-- 物品名:"生鱼肉"
        FISHMEAT_COOKED = "滑嫩的口感",		-- 物品名:"鱼排"
        FISHMEAT_SMALL = "太小了！",		-- 物品名:"小鱼块"
        FISHMEAT_SMALL_COOKED = "这有刺吗？",		-- 物品名:"烤小鱼块"
		SPOILED_FISH = "腐朽的气息",		-- 物品名:"变质的鱼"
		FISH_BOX = "也许我可以开个养殖场？",		-- 物品名:"锡鱼桶" 制造描述:"保持鱼与网捕之日一样新鲜"
        POCKET_SCALE = "这是称鱼的，不要看我！",		-- 物品名:"弹簧秤" 制造描述:"随时称鱼的重量！"
		TROPHYSCALE_FISH =
		{
			GENERIC = "这是称鱼的，不要看我！",		-- 物品名:"鱼类计重器"->默认 制造描述:"炫耀你的斩获"
			HAS_ITEM = "重量: {weight}\n捕获人: {owner}",		-- 物品名:"鱼类计重器" 制造描述:"炫耀你的斩获"
			BURNING = "我的鱼！！",		-- 物品名:"鱼类计重器"->正在燃烧 制造描述:"炫耀你的斩获"
			BURNT = "复原魔法不起作用了",		-- 物品名:"鱼类计重器"->烧焦的 制造描述:"炫耀你的斩获"
			OWNER = "重量: {weight}\n捕获人: {owner}\n当然是伊蕾娜的最棒了！",		-- 物品名:"鱼类计重器" 制造描述:"炫耀你的斩获"
		},
		OCEANFISHABLEFLOTSAM = "有谁来过吗？",		-- 物品名:"海洋残骸"
		CALIFORNIAROLL = "便利的吃法！",		-- 物品名:"加州卷"
		SEAFOODGUMBO = "味道十分鲜美！",		-- 物品名:"海鲜浓汤"
		SURFNTURF = "有营养！",		-- 物品名:"海鲜大排档"
		GHOSTLYELIXIR_SLOWREGEN = "灵魂魔法药剂！",		-- 物品名:"亡者补药" 制造描述:"时间会抚平所有伤口"
		GHOSTLYELIXIR_FASTREGEN = "灵魂魔法药剂！",		-- 物品名:"灵魂万灵药" 制造描述:"治疗重伤的强力药剂"
		GHOSTLYELIXIR_SHIELD = "灵魂魔法药剂！",		-- 物品名:"不屈药剂" 制造描述:"保护你的姐妹不受伤害"
		GHOSTLYELIXIR_ATTACK = "灵魂魔法药剂！",		-- 物品名:"易怒药水" 制造描述:"重燃阿比盖尔的战斗精神"
		GHOSTLYELIXIR_SPEED = "灵魂魔法药剂！",		-- 物品名:"强健精油" 制造描述:"给你的灵魂来一剂强心针"
		GHOSTLYELIXIR_RETALIATION = "灵魂魔法药剂！",		-- 物品名:"蒸馏复仇" 制造描述:"对敌人以牙还牙"
		SISTURN =
		{
			GENERIC = "上面寄托着思念",		-- 物品名:"姐妹骨灰罐"->默认 制造描述:"让你疲倦的灵魂休息的地方"
			SOME_FLOWERS = "需要一点装点花",		-- 物品名:"姐妹骨灰罐" 制造描述:"让你疲倦的灵魂休息的地方"
			LOTS_OF_FLOWERS = "原来不是……？",		-- 物品名:"姐妹骨灰罐" 制造描述:"让你疲倦的灵魂休息的地方"
		},
        PORTABLECOOKPOT_ITEM =
        {
            GENERIC = "便利的烹饪厨具",		-- 物品名:"便携烹饪锅"->默认 制造描述:"随时随地为美食家服务"
            DONE = "出锅了！",		-- 物品名:"便携烹饪锅"->完成了 制造描述:"随时随地为美食家服务"
			COOKING_LONG = "需要慢火烹饪",		-- 物品名:"便携烹饪锅"->饭还需要很久 制造描述:"随时随地为美食家服务"
			COOKING_SHORT = "差不多好了",		-- 物品名:"便携烹饪锅"->饭快做好了 制造描述:"随时随地为美食家服务"
			EMPTY = "做什么呢？",		-- 物品名:"便携烹饪锅" 制造描述:"随时随地为美食家服务"
        },
        PORTABLEBLENDER_ITEM = "调味料的加工厂",		-- 物品名:"便携研磨器" 制造描述:"把原料研磨成粉状调味品"
        PORTABLESPICER_ITEM =
        {
            GENERIC = "金黄色！",		-- 物品名:"便携香料站"->默认 制造描述:"调味让饭菜更可口" 神厨小福贵（doge）
            DONE = "真香！",		-- 物品名:"便携香料站"->完成了 制造描述:"调味让饭菜更可口"
        },
        SPICEPACK = "还不错嘛！",		-- 物品名:"厨师袋" 制造描述:"使你的食物保持新鲜"
        SPICE_GARLIC = "不能口臭！",		-- 物品名:"蒜粉" 制造描述:"用口臭防守是最好的进攻"
        SPICE_SUGAR = "加一点甜",		-- 物品名:"蜂蜜水晶" 制造描述:"令人心平气和的甜美"
        SPICE_CHILI = "酌量放吧！",		-- 物品名:"辣椒面" 制造描述:"刺激十足的粉末"
        SPICE_SALT = "放点盐大都会变得好吃的",		-- 物品名:"调味盐" 制造描述:"为你的饭菜加点咸味"
        MONSTERTARTARE = "黑暗料理？",		-- 物品名:"怪物鞑靼"
        FRESHFRUITCREPES = "想和伊蕾娜一起吃！",		-- 物品名:"鲜果可丽饼"
        FROGFISHBOWL = "新鲜的味道",		-- 物品名:"蓝带鱼排"
        POTATOTORNADO = "清脆可口！",		-- 物品名:"花式回旋块茎"
        DRAGONCHILISALAD = "身体都暖和起来！",		-- 物品名:"辣龙椒沙拉"
        GLOWBERRYMOUSSE = "蕴含魔力的料理！",		-- 物品名:"发光蓝莓慕斯"
        VOLTGOATJELLY = "蕴含魔力的料理！",		-- 物品名:"闪电羊肉冻"
        NIGHTMAREPIE = "味道还可以",		-- 物品名:"恐怖国王饼"
        BONESOUP = "有营养",		-- 物品名:"骨头汤"
        MASHEDPOTATOES = "软软的土豆泥，还有奶油！",		-- 物品名:"奶油土豆泥"
        POTATOSOUFFLE = "好吃！",		-- 物品名:"蓬松土豆酥"
        MOQUECA = "伊蕾娜做的真好吃！",		-- 物品名:"海鲜杂烩"
        GAZPACHO = "清凉起来！",		-- 物品名:"芦笋冷汤"
        ASPARAGUSSOUP = "清甜的味道！",		-- 物品名:"芦笋汤"
        VEGSTINGER = "我可以千杯不倒，我是说真的！",		-- 物品名:"辛辣鸡尾酒"
        BANANAPOP = "冰镇果盘！",		-- 物品名:"香蕉冻"
        CEVICHE = "完美地融合在了一起！",		-- 物品名:"酸橘汁腌鱼"
        SALSA = "调味更好！",		-- 物品名:"生鲜萨尔萨酱"
        PEPPERPOPPER = "好辣！？",		-- 物品名:"爆炒填馅辣椒"
        TURNIP = "好吃的",		-- 物品名:"大萝卜"
        TURNIP_COOKED = "煮了会更好吃？",		-- 物品名:"烤大萝卜"
        TURNIP_SEEDS = "种出更多的萝卜",		-- 物品名:"萝卜籽"
        GARLIC = "大蒜！！！",		-- 物品名:"大蒜"
        GARLIC_COOKED = "我不想吃！",		-- 物品名:"烤大蒜"
        GARLIC_SEEDS = "能种出更多的大蒜！",		-- 物品名:"蒜籽"
        ONION = "调味菜!",		-- 物品名:"洋葱"
        ONION_COOKED = "真香！",		-- 物品名:"烤洋葱"
        ONION_SEEDS = "种出更多的洋葱",		-- 物品名:"洋葱籽"
        POTATO = "常备食材",		-- 物品名:"土豆"
        POTATO_COOKED = "好吃",		-- 物品名:"烤土豆"
        POTATO_SEEDS = "种出更多的土豆！",		-- 物品名:"土豆籽"
        TOMATO = "酸酸甜甜！",		-- 物品名:"番茄"
        TOMATO_COOKED = "生吃可能更美味？",		-- 物品名:"烤番茄"
        TOMATO_SEEDS = "种出更多的番茄！",		-- 物品名:"番茄跟籽"
        ASPARAGUS = "芦笋!", 		-- 物品名:"芦笋"
        ASPARAGUS_COOKED = "煮汤或许更好吃？",		-- 物品名:"烤芦笋"
        ASPARAGUS_SEEDS = "长出更多的芦笋！",		-- 物品名:"芦笋种子"
        PEPPER = "调味品",		-- 物品名:"辣椒"
        PEPPER_COOKED = "魔鬼辣椒？",		-- 物品名:"烤辣椒"
        PEPPER_SEEDS = "种出更多的辣椒！",		-- 物品名:"辣椒籽"
        WEREITEM_BEAVER = "变身魔法",		-- 物品名:"俗气海狸像" 制造描述:"唤醒海狸人的诅咒"
        WEREITEM_GOOSE = "变身魔法",		-- 物品名:"俗气鹅像" 制造描述:"唤醒鹅人的诅咒"
        WEREITEM_MOOSE = "变身魔法",		-- 物品名:"俗气鹿像" 制造描述:"唤醒鹿人的诅咒"
        MERMHAT = "伪装魔法",		-- 物品名:"聪明的伪装" 制造描述:"鱼人化你的朋友"
        MERMTHRONE =
        {
            GENERIC = "皇家地毯？",		-- 物品名:"皇家地毯"->默认
            BURNT = "可惜了！",		-- 物品名:"皇家地毯"->烧焦的
        },        
        MERMTHRONE_CONSTRUCTION =
        {
            GENERIC = "我来建房子！",		-- 物品名:"皇家手工套装"->默认 制造描述:"建立一个新的鱼人王朝"
            BURNT = "烧完了！",		-- 物品名:"皇家手工套装"->烧焦的 制造描述:"建立一个新的鱼人王朝"
        },        
        MERMHOUSE_CRAFTED = 
        {
            GENERIC = "为什么要我来建房子！",		-- 物品名:"鱼人工艺屋"->默认 制造描述:"适合鱼人的家"
            BURNT = "与我无关！",		-- 物品名:"鱼人工艺屋"->烧焦的 制造描述:"适合鱼人的家"
        },
        MERMWATCHTOWER_REGULAR = "需要皇家卫士守护新国王！",		-- 物品名:"鱼人工艺屋" 制造描述:"适合鱼人的家"
        MERMWATCHTOWER_NOKING = "皇家护卫缺少国王……",		-- 物品名:"鱼人工艺屋" 制造描述:"适合鱼人的家"
        MERMKING = "兽人王",		-- 物品名:"鱼人之王"
        MERMGUARD = "看起来很气派的样子！",		-- 物品名:"忠诚鱼人守卫"
        MERM_PRINCE = "这是加冕仪式吗？",		-- 物品名:"过程中的皇室"
        SQUID = "鱿鱼，触手？",		-- 物品名:"鱿鱼"
		GHOSTFLOWER = "寄托思念的媒介",		-- 物品名:"哀悼荣耀"
        SMALLGHOST = "有意识的亡灵，你在找什么？",		-- 物品名:"小惊吓"
    },
    DESCRIBE_GENERIC = "那是什么？",		--检查物品描述的缺省值
    DESCRIBE_TOODARK = "看不见看不见~",		--天太黑
    DESCRIBE_SMOLDERING = "什么燃起来了",		--冒烟
    EAT_FOOD =
    {
        TALLBIRDEGG_CRACKED = "总是要填饱肚子的吧",		--吃孵化的高脚鸟蛋
		WINTERSFEASTFUEL = "呣，好甜！",		--暂无注释
    },
}


