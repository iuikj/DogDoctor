#
# -- 创建品种表（如果不存在）
# CREATE TABLE IF NOT EXISTS dog_breeds (
#     id INT AUTO_INCREMENT PRIMARY KEY,
#     english_name VARCHAR(100) NOT NULL UNIQUE,
#     chinese_name VARCHAR(100) NOT NULL,
#     description TEXT,
#     characteristics TEXT,
#     common_diseases TEXT,
#     temperament VARCHAR(200),
#     size_category VARCHAR(50),
#     life_expectancy VARCHAR(50),
#     origin_country VARCHAR(100),
#     care_level VARCHAR(50),
#     exercise_needs VARCHAR(50),
#     is_active BOOLEAN DEFAULT TRUE,
#     created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
#     updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
# );
#
#
# -- 清空现有数据
# DELETE FROM dog_breeds;


INSERT INTO dog_breeds
(english_name, chinese_name, description, characteristics, common_diseases, temperament, size_category, life_expectancy, origin_country, care_level, exercise_needs, is_active)
VALUES (
    'affenpinscher',
    '猴脸犬',
    '小型玩具犬，面部表情酷似猴子',
    '体型小巧；面部似猴；勇敢无畏；警惕性高',
    '髌骨脱臼；心脏病；眼部疾病；呼吸道问题',
    '勇敢、顽皮、忠诚',
    '小型',
    '12-15年',
    '德国',
    '一般',
    '低',
    TRUE
);

INSERT INTO dog_breeds
(english_name, chinese_name, description, characteristics, common_diseases, temperament, size_category, life_expectancy, origin_country, care_level, exercise_needs, is_active)
VALUES (
    'afghan_hound',
    '阿富汗猎犬',
    '优雅高贵的长毛猎犬，原产于阿富汗山区',
    '毛发丰厚飘逸；体型高大优雅；独立性强；跑步速度快',
    '髋关节发育不良；眼部疾病；甲状腺功能减退；胃扭转',
    '独立、高贵、温和但有距离感',
    '大型',
    '12-14年',
    '阿富汗',
    '困难',
    '高',
    TRUE
);

INSERT INTO dog_breeds
(english_name, chinese_name, description, characteristics, common_diseases, temperament, size_category, life_expectancy, origin_country, care_level, exercise_needs, is_active)
VALUES (
    'african_hunting_dog',
    '非洲野犬',
    '非洲原生野生犬科动物，群体狩猎',
    '斑驳色彩；群体生活；狩猎技巧高超；耐力极强',
    '狂犬病；寄生虫感染；营养不良；外伤',
    '野性、群体性强、警惕',
    '中型',
    '10-12年',
    '非洲',
    '困难',
    '高',
    TRUE
);

INSERT INTO dog_breeds
(english_name, chinese_name, description, characteristics, common_diseases, temperament, size_category, life_expectancy, origin_country, care_level, exercise_needs, is_active)
VALUES (
    'airedale',
    '万能梗',
    '最大的梗类犬，被称为''梗犬之王''',
    '体型高大；智商很高；多才多艺；忠诚勇敢',
    '髋关节发育不良；胃扭转；皮肤过敏；心脏病',
    '勇敢、聪明、独立',
    '大型',
    '11-14年',
    '英国',
    '一般',
    '高',
    TRUE
);

INSERT INTO dog_breeds
(english_name, chinese_name, description, characteristics, common_diseases, temperament, size_category, life_expectancy, origin_country, care_level, exercise_needs, is_active)
VALUES (
    'american_staffordshire_terrier',
    '美国斯塔福犬',
    '强壮的中型梗犬，肌肉发达',
    '肌肉发达；力量强大；勇敢无畏；忠诚度高',
    '髋关节发育不良；心脏病；皮肤过敏；白内障',
    '勇敢、忠诚、顽强',
    '中型',
    '12-16年',
    '美国',
    '一般',
    '高',
    TRUE
);

INSERT INTO dog_breeds
(english_name, chinese_name, description, characteristics, common_diseases, temperament, size_category, life_expectancy, origin_country, care_level, exercise_needs, is_active)
VALUES (
    'appenzeller',
    '阿彭策尔山犬',
    '瑞士牧羊犬之一，活泼健壮',
    '三色被毛；尾巴卷曲；精力充沛；警惕性高',
    '髋关节发育不良；眼部疾病；癫痫；胃扭转',
    '活泼、勇敢、忠诚',
    '中型',
    '13-15年',
    '瑞士',
    '一般',
    '高',
    TRUE
);

INSERT INTO dog_breeds
(english_name, chinese_name, description, characteristics, common_diseases, temperament, size_category, life_expectancy, origin_country, care_level, exercise_needs, is_active)
VALUES (
    'australian_terrier',
    '澳洲梗',
    '澳大利亚本土小型工作犬',
    '被毛粗糙；体型紧凑；勇敢机警；适应性强',
    '髌骨脱臼；糖尿病；过敏性皮炎；白内障',
    '勇敢、活泼、友善',
    '小型',
    '11-15年',
    '澳大利亚',
    '简单',
    '中',
    TRUE
);

INSERT INTO dog_breeds
(english_name, chinese_name, description, characteristics, common_diseases, temperament, size_category, life_expectancy, origin_country, care_level, exercise_needs, is_active)
VALUES (
    'australian_cattle_dog',
    '澳大利亚牧牛犬',
    '澳大利亚牧牛犬原产于19世纪的澳大利亚,是一种工作型犬种,主要用于放牧牛群。它们体格结实,耐力出众,能在恶劣环境下长途跋涉。这种犬非常聪明、忠诚、勇敢,对主人极其忠诚。它们有很强的保护欲,会保护主人及其财产。',
    '体型：中等体型,结实紧凑；身高：雄性45-51厘米,雌性43-48厘米；体重：16-23公斤；寿命：12-16年；毛色：蓝色斑点、蓝色杂色或红色杂色,可能带有棕褐色或黑棕色斑纹；性格特点：聪明、警觉、忠诚、保护欲强、精力充沛；运动需求：每天需要大量运动,至少2小时；适应环境：适合有大院子的家庭,不适合公寓生活；训练难度：容易训练,但需要早期社会化',
    '进行性视网膜萎缩(PRA)：遗传性眼病,会导致失明；髋关节发育不良：遗传性骨骼问题,可能导致关节炎；耳聋：部分个体可能先天性耳聋；膝关节脱位：膝盖骨滑出正常位置；眼睛问题：白内障、青光眼等；甲状腺功能减退：影响新陈代谢,需要药物治疗；出血性疾病：von Willebrand病等遗传性出血疾病；肝脏问题：门体分流等',
    '因犬而异，需要了解个体差异',
    '中型',
    '10-15年',
    '待确认',
    '一般',
    '中',
    TRUE
);

INSERT INTO dog_breeds
(english_name, chinese_name, description, characteristics, common_diseases, temperament, size_category, life_expectancy, origin_country, care_level, exercise_needs, is_active)
VALUES (
    'basenji',
    '巴辛吉犬',
    '不会吠叫的古老非洲猎犬，有独特的嚎叫声',
    '不会吠叫；体型紧凑；智商很高；清洁习惯好',
    '范可尼综合征；眼部疾病；髋关节发育不良；甲状腺疾病',
    '聪明、独立、好奇心强',
    '中型',
    '13-14年',
    '刚果',
    '一般',
    '高',
    TRUE
);

INSERT INTO dog_breeds
(english_name, chinese_name, description, characteristics, common_diseases, temperament, size_category, life_expectancy, origin_country, care_level, exercise_needs, is_active)
VALUES (
    'basset',
    '巴塞特猎犬',
    '短腿长身的嗅觉猎犬，性格温和',
    '腿短身长；嗅觉敏锐；性格温和；移动缓慢',
    '椎间盘疾病；肘关节发育不良；眼部疾病；耳部感染',
    '温和、友善、顽固',
    '中型',
    '12-13年',
    '法国',
    '一般',
    '低',
    TRUE
);

INSERT INTO dog_breeds
(english_name, chinese_name, description, characteristics, common_diseases, temperament, size_category, life_expectancy, origin_country, care_level, exercise_needs, is_active)
VALUES (
    'beagle',
    '比格犬',
    '友善活泼的小型猎犬，嗅觉敏锐',
    '嗅觉极佳；性格友善；体型适中；适合家庭饲养',
    '癫痫；髋关节发育不良；眼部疾病；甲状腺功能减退',
    '友善、好奇、温和',
    '中型',
    '10-15年',
    '英国',
    '简单',
    '中',
    TRUE
);

INSERT INTO dog_breeds
(english_name, chinese_name, description, characteristics, common_diseases, temperament, size_category, life_expectancy, origin_country, care_level, exercise_needs, is_active)
VALUES (
    'bedlington_terrier',
    '贝灵顿梗',
    '贝灵顿梗原产于英国诺森伯兰郡的贝灵顿镇,最初用于捕猎鼠类。这种犬看起来像小羊羔,有着独特的卷曲被毛和优雅的外表。它们性格温和,忠诚,是优秀的家庭伴侣犬。虽然外表温顺,但仍保持着梗类犬种的勇敢和活力。',
    '体型：中等体型；身高：38-44厘米；体重：8-10公斤；寿命：11-16年；毛色：蓝色、肝色、沙色或棕褐色；性格特点：聪明、活泼、忠诚、温和、警觉；运动需求：每天需要1小时运动；适应环境：适合公寓生活,但需要充分运动；训练难度：中等,可能较固执',
    '铜中毒症：遗传性肝脏疾病,导致铜在肝脏积累；眼部问题：白内障、干眼症、睫毛倒生、进行性视网膜萎缩；膝关节脱位：膝盖骨滑出正常位置；外分泌胰腺功能不全：消化酶分泌不足,影响营养吸收；癫痫：遗传性癫痫发作；库欣氏综合征：肾上腺分泌过多；牙齿问题：牙齿错位、缺失等遗传性问题；过敏：皮肤过敏,特别是对花粉和尘螨',
    '因犬而异，需要了解个体差异',
    '中型',
    '10-15年',
    '待确认',
    '一般',
    '中',
    TRUE
);

INSERT INTO dog_breeds
(english_name, chinese_name, description, characteristics, common_diseases, temperament, size_category, life_expectancy, origin_country, care_level, exercise_needs, is_active)
VALUES (
    'bernese_mountain_dog',
    '伯恩山犬',
    '伯恩山犬原产于瑞士山区,是一种古老的工作犬,曾被用于放牧、守卫和拉车。它们体型高大,性格温和友善,是优秀的家庭伴侣犬。这种犬以其独特的三色被毛和忠诚的性格而闻名,特别适合与儿童相处。',
    '体型：大型；身高：雄性64-70厘米,雌性58-66厘米；体重：雄性38-50公斤,雌性36-48公斤；寿命：7-10年；毛色：黑色底色,带有棕色和白色标记；性格特点：温和、忠诚、聪明、友善、适合家庭；运动需求：中等,每天需要适度运动；适应环境：适合凉爽气候,不耐热；训练难度：容易训练,但成长期需要耐心',
    '髋关节发育不良：遗传性骨骼问题,可能导致关节炎；肘关节发育不良：影响前肢关节发育,可能导致跛行；胃扭转：危及生命的急症,需要立即就医；恶性组织细胞瘤：最常见的癌症类型之一；血管肉瘤：常见于脾脏的恶性肿瘤；淋巴瘤：影响淋巴系统的癌症；白内障：常见于老年犬,可能导致视力问题；进行性视网膜萎缩：遗传性眼病,可能导致失明；冯·威布兰德氏病：遗传性出血性疾病；甲状腺功能减退：影响新陈代谢,需要终身治疗',
    '因犬而异，需要了解个体差异',
    '中型',
    '10-15年',
    '待确认',
    '一般',
    '中',
    TRUE
);

INSERT INTO dog_breeds
(english_name, chinese_name, description, characteristics, common_diseases, temperament, size_category, life_expectancy, origin_country, care_level, exercise_needs, is_active)
VALUES (
    'black-and-tan_coonhound',
    '黑褐猎浣熊犬',
    '黑褐猎浣熊犬原产于18世纪末的美国南部,是由猎血犬和猎狐犬杂交培育而成。这种犬以其出色的嗅觉和追踪能力而闻名,主要用于追踪浣熊、负鼠等猎物。它们性格温和友善,既是优秀的猎犬,也是忠实的家庭伴侣犬。',
    '体型：大型犬；身高：雄性58-69厘米,雌性53-63厘米；体重：29-45公斤；寿命：10-12年；毛色：黑色底色,带有棕褐色标记；性格特点：温和、友善、忠诚、独立、有耐心；运动需求：中等,每天需要1-2小时运动；适应环境：需要有围栏的院子,不适合公寓生活；训练难度：中等,可能较固执,需要耐心',
    '胃扭转：大型深胸犬常见的急症,需要及时就医；髋关节发育不良：遗传性骨骼问题,可能导致关节炎；耳部感染：下垂耳容易积累湿气和碎屑导致感染；眼睑外翻：眼睑外翻可能导致眼部刺激和感染；甲状腺功能减退：可能出现皮肤问题、体重增加等症状；白内障：老年犬常见的眼科疾病；进行性视网膜萎缩：遗传性眼病,可能导致失明；血友病：遗传性出血性疾病；浣熊犬瘫痪症：免疫系统对浣熊唾液的反应,可导致暂时性瘫痪',
    '因犬而异，需要了解个体差异',
    '中型',
    '10-15年',
    '待确认',
    '一般',
    '中',
    TRUE
);

INSERT INTO dog_breeds
(english_name, chinese_name, description, characteristics, common_diseases, temperament, size_category, life_expectancy, origin_country, care_level, exercise_needs, is_active)
VALUES (
    'blenheim_spaniel',
    '布伦海姆猎犬',
    '查尔斯王小猎犬的一个色系变种',
    '毛色红白相间；体型小巧；性格温和；眼睛大而圆',
    '心脏病；眼部疾病；癫痫；脊髓空洞症',
    '温和、友善、活泼',
    '小型',
    '12-15年',
    '英国',
    '一般',
    '低',
    TRUE
);

INSERT INTO dog_breeds
(english_name, chinese_name, description, characteristics, common_diseases, temperament, size_category, life_expectancy, origin_country, care_level, exercise_needs, is_active)
VALUES (
    'bloodhound',
    '寻血猎犬',
    '世界上嗅觉最敏锐的犬种之一',
    '嗅觉超强；体型巨大；性格温和；追踪能力出色',
    '胃扭转；髋关节发育不良；眼部疾病；皮肤感染',
    '温和、坚韧、专注',
    '大型',
    '10-12年',
    '比利时',
    '一般',
    '中',
    TRUE
);

INSERT INTO dog_breeds
(english_name, chinese_name, description, characteristics, common_diseases, temperament, size_category, life_expectancy, origin_country, care_level, exercise_needs, is_active)
VALUES (
    'bluetick',
    '蓝斑浣熊猎犬',
    '美国南部培育的专业浣熊猎犬',
    '蓝色斑点被毛；嗅觉敏锐；耐力出色；声音洪亮',
    '髋关节发育不良；耳部感染；胃扭转；眼部疾病',
    '友善、勇敢、坚韧',
    '大型',
    '11-12年',
    '美国',
    '一般',
    '高',
    TRUE
);

INSERT INTO dog_breeds
(english_name, chinese_name, description, characteristics, common_diseases, temperament, size_category, life_expectancy, origin_country, care_level, exercise_needs, is_active)
VALUES (
    'border_collie',
    '边境牧羊犬',
    '智商最高的犬种，优秀的牧羊犬',
    '智商极高；精力充沛；学习能力强；工作欲望强',
    '髋关节发育不良；眼部疾病；癫痫；骨软骨病',
    '聪明、勤奋、敏感',
    '中型',
    '12-15年',
    '英国',
    '困难',
    '高',
    TRUE
);

INSERT INTO dog_breeds
(english_name, chinese_name, description, characteristics, common_diseases, temperament, size_category, life_expectancy, origin_country, care_level, exercise_needs, is_active)
VALUES (
    'border_terrier',
    '边境梗',
    '来自英格兰边境地区的工作梗犬',
    '被毛粗糙；体型紧凑；勇敢坚韧；适应性强',
    '髋关节发育不良；心脏病；癫痫；眼部疾病',
    '勇敢、友善、顽强',
    '小型',
    '13-15年',
    '英国',
    '简单',
    '中',
    TRUE
);

INSERT INTO dog_breeds
(english_name, chinese_name, description, characteristics, common_diseases, temperament, size_category, life_expectancy, origin_country, care_level, exercise_needs, is_active)
VALUES (
    'borzoi',
    '俄罗斯猎狼犬',
    '优雅的俄罗斯视觉猎犬，曾是贵族专用',
    '体型修长优雅；奔跑速度极快；毛发丝质；性格安静',
    '心脏病；胃扭转；甲状腺功能减退；骨肉瘤',
    '安静、优雅、独立',
    '大型',
    '10-12年',
    '俄罗斯',
    '一般',
    '中',
    TRUE
);

INSERT INTO dog_breeds
(english_name, chinese_name, description, characteristics, common_diseases, temperament, size_category, life_expectancy, origin_country, care_level, exercise_needs, is_active)
VALUES (
    'boston_bull',
    '波士顿梗',
    '美国培育的紧凑型伴侣犬',
    '体型紧凑；燕尾服色彩；性格温和；适合城市生活',
    '呼吸道问题；眼部疾病；髌骨脱臼；脊椎疾病',
    '友善、聪明、活泼',
    '小型',
    '11-13年',
    '美国',
    '简单',
    '低',
    TRUE
);

INSERT INTO dog_breeds
(english_name, chinese_name, description, characteristics, common_diseases, temperament, size_category, life_expectancy, origin_country, care_level, exercise_needs, is_active)
VALUES (
    'bouvier_des_flandres',
    '法兰德斯牧牛犬',
    '比利时和法国边境的大型工作犬',
    '体型巨大；被毛粗糙；力量强大；工作能力强',
    '髋关节发育不良；肘关节发育不良；眼部疾病；胃扭转',
    '勇敢、冷静、保护性强',
    '大型',
    '10-12年',
    '比利时/法国',
    '困难',
    '高',
    TRUE
);

INSERT INTO dog_breeds
(english_name, chinese_name, description, characteristics, common_diseases, temperament, size_category, life_expectancy, origin_country, care_level, exercise_needs, is_active)
VALUES (
    'boxer',
    '拳师犬',
    '德国培育的中型工作犬，活泼友善',
    '面部扁平；肌肉发达；精力充沛；忠诚度高',
    '心脏病；癌症；髋关节发育不良；胃扭转',
    '活泼、友善、勇敢',
    '大型',
    '10-12年',
    '德国',
    '一般',
    '高',
    TRUE
);

INSERT INTO dog_breeds
(english_name, chinese_name, description, characteristics, common_diseases, temperament, size_category, life_expectancy, origin_country, care_level, exercise_needs, is_active)
VALUES (
    'brabancon_griffon',
    '布拉班特狮毛犬',
    '比利时小型玩具犬，面部表情丰富',
    '面部似人；体型小巧；表情丰富；警惕性高',
    '呼吸道问题；眼部疾病；髌骨脱臼；心脏病',
    '聪明、警惕、自信',
    '小型',
    '14-15年',
    '比利时',
    '一般',
    '低',
    TRUE
);

INSERT INTO dog_breeds
(english_name, chinese_name, description, characteristics, common_diseases, temperament, size_category, life_expectancy, origin_country, care_level, exercise_needs, is_active)
VALUES (
    'briard',
    '布里犬',
    '法国古老的牧羊犬，被毛丰厚',
    '被毛长而丰厚；体型高大；智商很高；保护欲强',
    '髋关节发育不良；眼部疾病；胃扭转；甲状腺疾病',
    '忠诚、勇敢、聪明',
    '大型',
    '12年',
    '法国',
    '困难',
    '高',
    TRUE
);

INSERT INTO dog_breeds
(english_name, chinese_name, description, characteristics, common_diseases, temperament, size_category, life_expectancy, origin_country, care_level, exercise_needs, is_active)
VALUES (
    'brittany_spaniel',
    '布列塔尼犬',
    '法国培育的优秀指示猎犬',
    '精力充沛；嗅觉敏锐；工作能力强；适应性好',
    '髋关节发育不良；眼部疾病；癫痫；甲状腺疾病',
    '友善、积极、聪明',
    '中型',
    '12-15年',
    '法国',
    '一般',
    '高',
    TRUE
);

INSERT INTO dog_breeds
(english_name, chinese_name, description, characteristics, common_diseases, temperament, size_category, life_expectancy, origin_country, care_level, exercise_needs, is_active)
VALUES (
    'bull_mastiff',
    '斗牛獒',
    '英国培育的大型护卫犬',
    '体型巨大；力量强大；勇敢无畏；忠诚度高',
    '髋关节发育不良；肘关节发育不良；心脏病；胃扭转',
    '勇敢、冷静、忠诚',
    '大型',
    '7-9年',
    '英国',
    '一般',
    '中',
    TRUE
);

INSERT INTO dog_breeds
(english_name, chinese_name, description, characteristics, common_diseases, temperament, size_category, life_expectancy, origin_country, care_level, exercise_needs, is_active)
VALUES (
    'black_and_tan_coonhound',
    '黑褐猎浣熊犬',
    '黑褐猎浣熊犬原产于18世纪末的美国南部,是由猎血犬和猎狐犬杂交培育而成。这种犬以其出色的嗅觉和追踪能力而闻名,主要用于追踪浣熊、负鼠等猎物。它们性格温和友善,既是优秀的猎犬,也是忠实的家庭伴侣犬。',
    '体型：大型犬；身高：雄性58-69厘米,雌性53-63厘米；体重：29-45公斤；寿命：10-12年；毛色：黑色底色,带有棕褐色标记；性格特点：温和、友善、忠诚、独立、有耐心；运动需求：中等,每天需要1-2小时运动；适应环境：需要有围栏的院子,不适合公寓生活；训练难度：中等,可能较固执,需要耐心',
    '胃扭转：大型深胸犬常见的急症,需要及时就医；髋关节发育不良：遗传性骨骼问题,可能导致关节炎；耳部感染：下垂耳容易积累湿气和碎屑导致感染；眼睑外翻：眼睑外翻可能导致眼部刺激和感染；甲状腺功能减退：可能出现皮肤问题、体重增加等症状；白内障：老年犬常见的眼科疾病；进行性视网膜萎缩：遗传性眼病,可能导致失明；血友病：遗传性出血性疾病；浣熊犬瘫痪症：免疫系统对浣熊唾液的反应,可导致暂时性瘫痪',
    '因犬而异，需要了解个体差异',
    '中型',
    '10-15年',
    '待确认',
    '一般',
    '中',
    TRUE
);

INSERT INTO dog_breeds
(english_name, chinese_name, description, characteristics, common_diseases, temperament, size_category, life_expectancy, origin_country, care_level, exercise_needs, is_active)
VALUES (
    'brittany',
    '布列塔尼猎犬',
    '布列塔尼猎犬原产于18世纪的法国布列塔尼地区,是一种多才多艺的狩猎犬。它们以出色的嗅觉和追踪能力而闻名,主要用于狩猎鸟类。这种犬不仅是优秀的猎犬,也是充满活力的家庭伴侣犬,性格温和友善,特别适合活跃的家庭。',
    '体型：中等体型；身高：雄性48-52厘米,雌性47-50厘米；体重：14-18公斤；寿命：12-14年；毛色：橙白色、肝白色、黑白色或三色；性格特点：聪明、活泼、温和、忠诚、精力充沛；运动需求：需要大量运动,每天至少1-2小时；适应环境：需要有院子,不适合公寓生活；训练难度：容易训练,但需要保持耐心',
    '髋关节发育不良：遗传性骨骼问题,可能导致关节炎；肘关节发育不良：影响前肢关节发育,可能导致跛行；癫痫：遗传性疾病,通常在6个月到3岁之间发病；白内障：老年犬常见,导致视力模糊；青光眼：严重的眼部疾病,需要及时治疗；甲状腺功能减退：影响新陈代谢,可能导致体重增加和皮肤问题；耳部感染：下垂耳容易积累湿气和碎屑导致感染；过敏性皮炎：常见的皮肤过敏问题；小脑退化：遗传性神经系统疾病,影响平衡和协调能力',
    '因犬而异，需要了解个体差异',
    '中型',
    '10-15年',
    '待确认',
    '一般',
    '中',
    TRUE
);

INSERT INTO dog_breeds
(english_name, chinese_name, description, characteristics, common_diseases, temperament, size_category, life_expectancy, origin_country, care_level, exercise_needs, is_active)
VALUES (
    'bulldog',
    '斗牛犬',
    '斗牛犬以其宽阔的站姿、肌肉发达的低矮体型和短皱的脸部特征著称。虽然体型较矮(仅14-15英寸高),但体重可达40-50磅。它们有下垂的嘴唇,脸部和颈部有许多松弛的皮肤褶皱。经过几代选择性繁育,现代斗牛犬已经从最初的斗牛犬变成了温和甚至有些懒散的家庭伴侣犬。',
    '体型：中等体型,结实紧凑；身高：雄性36-38厘米,雌性35-37厘米；体重：18-23公斤；寿命：8-10年；毛色：红色、白色、褐色或斑纹；性格特点：温和、友善、忠诚、适合家庭；运动需求：低到中等,每天需要适度运动；适应环境：适合室内生活,不耐高温；训练难度：中等,需要耐心和一致性',
    '呼吸道综合征：由短鼻子导致的呼吸困难,可能需要手术矫正；皮肤感染：皮肤褶皱处容易滋生细菌和酵母菌；髋关节发育不良：遗传性骨骼问题,可能导致关节炎；眼部问题：樱桃眼、内翻、白内障等多种眼部疾病；心脏病：随年龄增长可能出现心脏杂音和心力衰竭；过敏：容易出现皮肤过敏和食物过敏；中暑：由于短鼻子和呼吸困难,容易在高温天气中中暑；牙齿问题：特别容易出现牙齿疾病,需要定期清洁；肥胖：容易发胖,需要控制饮食和保持适度运动',
    '因犬而异，需要了解个体差异',
    '中型',
    '10-15年',
    '待确认',
    '一般',
    '中',
    TRUE
);

INSERT INTO dog_breeds
(english_name, chinese_name, description, characteristics, common_diseases, temperament, size_category, life_expectancy, origin_country, care_level, exercise_needs, is_active)
VALUES (
    'chihuahua',
    '吉娃娃',
    '吉娃娃是世界上最小的犬种,原产于墨西哥。它们以其小巧的体型、大大的眼睛和直立的耳朵而闻名。尽管体型娇小,但性格活泼、勇敢,是非常忠诚的伴侣犬。吉娃娃分为短毛和长毛两种,头型有苹果头和鹿头之分。',
    '体型：超小型；身高：15-23厘米；体重：1-3公斤；寿命：12-16年；毛色：多种,包括黑色、白色、褐色、奶油色等,可以是纯色或混色；性格特点：机警、活泼、忠诚、勇敢、自信；运动需求：中等,每天需要适度运动和室内游戏；适应环境：适合室内生活,不耐寒；训练难度：中等,需要耐心和正面强化训练',
    '牙齿问题：由于口腔较小容易导致牙齿拥挤,易患牙周病和蛀牙；膝盖骨脱位：遗传性疾病,会导致跛行和关节炎；气管塌陷：常见于小型犬,会导致呼吸困难和咳嗽；心脏病：特别是二尖瓣疾病,是老年吉娃娃的主要死因；脑积水：头部软斑过大可能导致脑积水,影响神经系统；低血糖：特别是幼犬和体型较小的个体容易发生；眼部问题：包括青光眼、白内障和进行性视网膜萎缩；骨折风险：由于体型娇小,容易发生意外骨折；过敏：皮肤过敏和食物过敏较为常见；肥胖：容易过度喂食导致肥胖,需要控制饮食',
    '因犬而异，需要了解个体差异',
    '中型',
    '10-15年',
    '待确认',
    '一般',
    '中',
    TRUE
);

INSERT INTO dog_breeds
(english_name, chinese_name, description, characteristics, common_diseases, temperament, size_category, life_expectancy, origin_country, care_level, exercise_needs, is_active)
VALUES (
    'chow_chow',
    '松狮犬',
    '松狮犬是一种古老的中国犬种,历史可追溯到汉朝时期。它们原名''松狮犬''意为''狮子狗'',因其独特的狮子般的外表而得名。这种犬以其独特的蓝黑色舌头、厚实的毛发和高贵的气质而闻名。虽然外表威严,但性格独立且忠诚,是优秀的家庭伴侣犬和护卫犬。',
    '体型：中大型；身高：雄性48-56厘米,雌性46-51厘米；体重：雄性25-32公斤,雌性20-27公斤；寿命：8-12年；毛色：红色、黑色、蓝色、奶油色或肉桂色；性格特点：独立、忠诚、高贵、警惕、有保护欲；运动需求：中等,每天需要适度运动；适应环境：适应性强,但不耐高温；训练难度：较难训练,需要耐心和一致性',
    '髋关节发育不良：遗传性骨骼问题,可能导致关节炎和行动不便；肘关节发育不良：影响前肢关节发育,可能导致跛行；眼睑内翻：眼睑向内卷曲,导致睫毛摩擦角膜,需要手术矫正；甲状腺功能减退：影响新陈代谢,导致体重增加和皮肤问题；胃扭转：严重的急症,需要立即就医；热应激：因厚实的被毛容易中暑,需要避免暴露在高温环境；皮肤问题：容易出现皮肤感染和过敏；白内障：可能导致视力问题,老年犬较常见；心脏病：可能出现各种心脏问题,需要定期检查；糖尿病：较常见,需要胰岛素治疗和严格的饮食管理',
    '因犬而异，需要了解个体差异',
    '中型',
    '10-15年',
    '待确认',
    '一般',
    '中',
    TRUE
);

INSERT INTO dog_breeds
(english_name, chinese_name, description, characteristics, common_diseases, temperament, size_category, life_expectancy, origin_country, care_level, exercise_needs, is_active)
VALUES (
    'collie',
    '柯利牧羊犬',
    '柯利牧羊犬原产于苏格兰和英格兰,是一种古老的牧羊犬。它们以其优雅的外表、聪明的头脑和忠诚的性格而闻名。柯利犬分为长毛(粗毛)和短毛(光滑)两种,其中长毛品种因电视剧《灵犬莱西》而广受欢迎。它们不仅是出色的工作犬,更是理想的家庭伴侣犬。',
    '体型：中大型；身高：雄性56-61厘米,雌性51-56厘米；体重：23-34公斤；寿命：10-14年；毛色：黄褐色和白色、三色、蓝色斑纹、纯白色；性格特点：聪明、忠诚、温和、敏感、警觉；运动需求：每天需要至少1小时运动；适应环境：适应性强,但不耐高温；训练难度：容易训练,但需要保持新鲜感',
    '柯利眼异常：遗传性眼病,可能导致失明；多药耐药基因缺陷(MDR1)：影响某些药物代谢,需要特别注意用药；进行性视网膜萎缩：遗传性眼病,可能导致失明；皮肌炎：影响皮肤和肌肉的炎症性疾病；髋关节发育不良：遗传性骨骼问题；胃扭转：急性致命疾病,需要立即就医；癫痫：可能出现遗传性癫痫；自身免疫性皮肤病：可能出现皮肤问题；外分泌胰腺功能不全：影响食物消化和营养吸收；脱髓鞘性疾病：影响神经系统,可能导致后肢瘫痪',
    '因犬而异，需要了解个体差异',
    '中型',
    '10-15年',
    '待确认',
    '一般',
    '中',
    TRUE
);

INSERT INTO dog_breeds
(english_name, chinese_name, description, characteristics, common_diseases, temperament, size_category, life_expectancy, origin_country, care_level, exercise_needs, is_active)
VALUES (
    'dingo',
    '澳洲野犬',
    '澳洲野犬(Dingo)是澳大利亚的原生犬种,已在澳洲生存了数千年。它们是高度适应性的野生犬,具有灵活的身体和敏捷的行动能力。虽然有些人尝试将其驯化为宠物,但它们本质上仍保持着野性特征。野犬在澳大利亚的生态系统中扮演着重要角色。',
    '体型：中等体型；身高：52-60厘米；体重：13-20公斤；寿命：10-13年(野外)；毛色：主要为沙黄色,也可能有白色或黑色标记；性格特点：独立、警惕、机敏、野性强、适应力强；运动需求：需要大量运动和活动空间；适应环境：适应野外环境,不适合作为普通家庭宠物；训练难度：极难驯化,保持野性本能',
    '寄生虫感染：野外常见的内外寄生虫问题；犬瘟热：野生种群中的常见传染病；狂犬病：可能感染的致命病毒；关节问题：年老时可能出现关节炎；皮肤病：外部寄生虫导致的皮肤问题；牙齿问题：野外生活导致的牙齿磨损和感染',
    '因犬而异，需要了解个体差异',
    '中型',
    '10-15年',
    '待确认',
    '一般',
    '中',
    TRUE
);

INSERT INTO dog_breeds
(english_name, chinese_name, description, characteristics, common_diseases, temperament, size_category, life_expectancy, origin_country, care_level, exercise_needs, is_active)
VALUES (
    'doberman_pinscher',
    '杜宾犬',
    '杜宾犬原产于19世纪末的德国,由路易斯·多伯曼培育。这种犬以其优雅的外形、出色的智商和忠诚的性格而闻名。它们原本被培育用作护卫犬和警犬,现在则是优秀的家庭伴侣犬。杜宾犬体格健壮,肌肉发达,动作优雅灵活。',
    '体型：中大型；身高：雄性66-71厘米,雌性61-66厘米；体重：雄性38-45公斤,雌性32-35公斤；寿命：10-13年；毛色：黑色、红色、蓝色或褐色,都带有棕褐色斑纹；性格特点：聪明、忠诚、警觉、保护欲强、容易训练；运动需求：需要大量运动,每天至少1-2小时；适应环境：适应家居生活,不耐寒；训练难度：容易训练,但需要早期社会化',
    '心脏病：易患扩张型心肌病(DCM),需要定期心脏检查；颈椎病：易患沃伯氏综合征,可能导致行走不稳；凝血功能障碍：易患冯·威布兰德氏病,影响血液凝固；胃扭转：深胸犬种常见的急症,需要及时治疗；甲状腺功能减退：可能出现皮肤问题、体重增加等症状；肝脏疾病：易患慢性活动性肝炎,需要定期检查；眼部疾病：可能患进行性视网膜萎缩等眼部疾病；髋关节发育不良：遗传性骨骼问题,可能导致关节炎',
    '因犬而异，需要了解个体差异',
    '中型',
    '10-15年',
    '待确认',
    '一般',
    '中',
    TRUE
);

INSERT INTO dog_breeds
(english_name, chinese_name, description, characteristics, common_diseases, temperament, size_category, life_expectancy, origin_country, care_level, exercise_needs, is_active)
VALUES (
    'english_cocker_spaniel',
    '英国可卡犬',
    '英国可卡犬原产于英国,是一种古老的狩猎犬种,主要用于狩猎鸟类。它们以其愉快的性格和优雅的外表而闻名,是非常受欢迎的家庭伴侣犬。这种犬以其长耳朵和柔顺的被毛为特征,性格温和友善,对主人非常忠诚。',
    '体型：中等体型；身高：雄性38-41厘米,雌性36-39厘米；体重：13-14.5公斤；寿命：12-15年；毛色：多种颜色,包括黑色、金色、红色、棕色等,可以是纯色或混色；性格特点：快乐、温和、聪明、活泼、忠诚；运动需求：每天需要1小时以上的运动；适应环境：适应性强,适合家庭生活；训练难度：容易训练,但需要耐心和一致性',
    '耳部感染：长耳朵容易积累湿气和碎屑,易发生感染；眼部问题：易患进行性视网膜萎缩(PRA)、青光眼、白内障；髋关节发育不良：遗传性骨骼问题,可能导致关节炎；免疫性溶血性贫血：自身免疫系统攻击红血细胞；皮肤问题：易患皮脂溢和各种皮肤过敏；肾脏疾病：可能患上家族性肾病；甲状腺功能减退：影响新陈代谢,可能导致皮肤问题和体重增加；癫痫：可能出现遗传性癫痫；膝盖骨脱位：膝盖骨滑出正常位置；心脏病：老年犬易患二尖瓣疾病',
    '因犬而异，需要了解个体差异',
    '中型',
    '10-15年',
    '待确认',
    '一般',
    '中',
    TRUE
);

INSERT INTO dog_breeds
(english_name, chinese_name, description, characteristics, common_diseases, temperament, size_category, life_expectancy, origin_country, care_level, exercise_needs, is_active)
VALUES (
    'german_shepherd',
    '德国牧羊犬',
    '德国牧羊犬原产于德国，最初是一种牧羊犬，后来因其出色的工作能力成为世界上最受欢迎的警犬和军犬之一。它们以其高智商、忠诚度和工作能力而闻名。德国牧羊犬体格强健，气质威严，是优秀的工作犬和家庭伴侣犬。',
    '体型：大型；身高：雄性60-65厘米，雌性55-60厘米；体重：雄性30-40公斤，雌性22-32公斤；寿命：9-13年；毛色：黑色和棕色、纯黑色、灰色等，通常为双层被毛；性格特点：聪明、忠诚、勇敢、警觉、自信；运动需求：需要大量运动，每天至少2小时；适应环境：适应能力强，但需要足够的活动空间；训练难度：容易训练，但需要经验丰富的主人',
    '髋关节发育不良：遗传性疾病，可能导致后肢瘫痪；肘关节发育不良：影响前肢关节发育，可能导致跛行；脊椎问题：易患椎间盘疾病和退行性脊髓病；胰腺外分泌功能不全：影响食物消化和营养吸收；眼部疾病：易患白内障、进行性视网膜萎缩；消化系统问题：易患胃扭转和炎症性肠病；过敏：对某些食物和环境因素敏感',
    '因犬而异，需要了解个体差异',
    '中型',
    '10-15年',
    '待确认',
    '一般',
    '中',
    TRUE
);

INSERT INTO dog_breeds
(english_name, chinese_name, description, characteristics, common_diseases, temperament, size_category, life_expectancy, origin_country, care_level, exercise_needs, is_active)
VALUES (
    'golden_retriever',
    '金毛寻回犬',
    '金毛寻回犬原产于19世纪的苏格兰高地，由特威德茅斯勋爵培育。它们以其友善的性格、高智商和优雅的外形而闻名。金毛寻回犬不仅是优秀的家庭伴侣犬，还可以胜任导盲犬、搜救犬、警犬等工作。它们拥有浓密的金色被毛，性格温和友好，是最受欢迎的犬种之一。',
    '体型：中大型；身高：雄性56-61厘米，雌性51-56厘米；体重：雄性27-36公斤，雌性25-32公斤；寿命：10-12年；毛色：从奶油色到深金色，被毛浓密有光泽；性格特点：温和、友善、聪明、忠诚、活泼、易训练；运动需求：需要大量运动，每天至少1-2小时；适应环境：适应性强，适合家庭生活；训练难度：容易训练，学习能力强',
    '癌症：易患多种癌症，包括淋巴瘤、血管肉瘤和肥大细胞瘤；髋关节发育不良：遗传性疾病，可能导致关节炎和行动不便；肘关节发育不良：影响前肢关节发育，可能导致跛行；眼部疾病：易患白内障、青光眼、进行性视网膜萎缩；皮肤过敏：容易出现皮肤过敏和热点；心脏病：易患主动脉狭窄和扩张型心肌病；甲状腺功能减退：影响新陈代谢，可能导致体重增加和皮毛问题；耳部感染：由于耳朵下垂，容易发生耳道感染',
    '因犬而异，需要了解个体差异',
    '中型',
    '10-15年',
    '待确认',
    '一般',
    '中',
    TRUE
);

INSERT INTO dog_breeds
(english_name, chinese_name, description, characteristics, common_diseases, temperament, size_category, life_expectancy, origin_country, care_level, exercise_needs, is_active)
VALUES (
    'great_dane',
    '大丹犬',
    '大丹犬原产于德国，最初被培育用于狩猎野猪和看守庄园。它们以其巨大的体型和温和的性格而闻名，被誉为''犬中阿波罗''。尽管体型庞大，但大丹犬性格温和友善，是典型的''温柔巨人''，非常适合作为家庭伴侣犬。它们对主人非常忠诚，与孩子相处融洽，具有出色的看家护院能力。',
    '体型：巨型；身高：雄性76-86厘米，雌性71-81厘米；体重：雄性54-90公斤，雌性45-59公斤；寿命：7-10年；毛色：黑色、蓝色、金黄色、斑纹、哈林琴花纹等；性格特点：温和、友善、忠诚、勇敢、警觉、容易训练；运动需求：中等，每天需要适量运动；适应环境：适应家居生活，需要足够的活动空间；训练难度：容易训练，但需要早期社会化',
    '胃扭转：最常见且危险的健康问题，需要及时治疗；心脏病：易患扩张型心肌病，需要定期检查；髋关节发育不良：常见的遗传性骨骼问题；骨肉瘤：好发于中年大型犬，早期症状包括跛行和腿部疼痛；甲状腺功能减退：可能导致皮肤问题和行为改变；颈椎病：易患沃伯氏综合征，可能导致行走不稳；眼部疾病：可能出现白内障、青光眼等问题；自身免疫性疾病：包括溶血性贫血和血小板减少',
    '因犬而异，需要了解个体差异',
    '中型',
    '10-15年',
    '待确认',
    '一般',
    '中',
    TRUE
);

INSERT INTO dog_breeds
(english_name, chinese_name, description, characteristics, common_diseases, temperament, size_category, life_expectancy, origin_country, care_level, exercise_needs, is_active)
VALUES (
    'irish_setter',
    '爱尔兰雪达犬',
    '爱尔兰雪达犬原产于18世纪的爱尔兰，最初被培育用于追踪、指示和取回猎物。它们以其光泽的红色被毛和甜美的性格而闻名。这种犬不仅是优秀的猎犬，也是出色的家庭伴侣犬。它们性格开朗活泼，对家人非常忠诚，与孩子和其他宠物相处融洽。',
    '体型：中大型；身高：雄性66-71厘米，雌性61-66厘米；体重：雄性27-32公斤，雌性25-29公斤；寿命：12-15年；毛色：栗红色到深红棕色，被毛光泽柔顺；性格特点：温和、友善、聪明、活泼、忠诚、精力充沛；运动需求：需要大量运动，每天至少1-2小时；适应环境：适应家居生活，需要足够的活动空间；训练难度：中等，性格敏感，需要耐心和一致性',
    '胃扭转：深胸犬种易患胃扭转，需要注意预防和及时治疗；髋关节发育不良：遗传性疾病，可能导致关节炎；进行性视网膜萎缩：遗传性眼病，可能导致失明；免疫性溶血性贫血：免疫系统攻击自身红血细胞导致贫血；甲状腺功能减退：影响新陈代谢，需要定期检查；耳部感染：长耳朵容易积累湿气，需要定期清理；癫痫：可能出现遗传性癫痫，需要药物控制；骨骼炎症：生长期可能出现骨骼炎症(panosteitis)',
    '因犬而异，需要了解个体差异',
    '中型',
    '10-15年',
    '待确认',
    '一般',
    '中',
    TRUE
);

INSERT INTO dog_breeds
(english_name, chinese_name, description, characteristics, common_diseases, temperament, size_category, life_expectancy, origin_country, care_level, exercise_needs, is_active)
VALUES (
    'japanese_chin',
    '日本狆',
    '日本狆虽然名字带有日本，但实际起源于古代中国。它们最初是作为皇室贵族的宠物犬而被培育，后来作为礼物被赠送给日本皇室。这种犬以其优雅的外表和猫咪般的性格而闻名。它们体型小巧，性格温和，是理想的室内伴侣犬。',
    '体型：小型；身高：20-28厘米；体重：1.8-5公斤；寿命：10-12年；毛色：黑白色或红白色，有时为三色；性格特点：优雅、聪明、独立、温和、忠诚、有尊严；运动需求：低，每天短距离散步即可；适应环境：非常适合公寓生活，不耐热；训练难度：中等，需要耐心和正面激励',
    '呼吸系统问题：由于短鼻子构造，容易出现呼吸困难和打鼾；心脏病：易患心脏瓣膜疾病，需要定期检查；眼部疾病：易患白内障、眼睑内翻和睫毛倒生；膝盖脱位：常见的遗传性骨骼问题；脊椎问题：容易出现颈椎不稳和脊椎畸形；甲状腺功能减退：可能出现皮肤、毛发和行为问题',
    '因犬而异，需要了解个体差异',
    '中型',
    '10-15年',
    '待确认',
    '一般',
    '中',
    TRUE
);

INSERT INTO dog_breeds
(english_name, chinese_name, description, characteristics, common_diseases, temperament, size_category, life_expectancy, origin_country, care_level, exercise_needs, is_active)
VALUES (
    'keeshond',
    '荷兰毛狮犬',
    '荷兰毛狮犬原产于荷兰，最初是作为驳船上的看门狗和伴侣犬而被培育。它们因其独特的''微笑''表情而被称为''微笑的荷兰人''。这种犬以其浓密的双层被毛和特有的''眼镜''面部标记而闻名。它们性格活泼开朗，对家人非常忠诚，是优秀的家庭伴侣犬。',
    '体型：中型；身高：43-46厘米；体重：16-20公斤；寿命：12-15年；毛色：灰色和黑色混合，带有浅灰色或奶油色的底毛；性格特点：聪明、活泼、忠诚、警觉、友善、适应性强；运动需求：中等，每天需要适量运动；适应环境：适应多种生活环境，但不耐高温；训练难度：容易训练，但有时会有独立倔强的一面',
    '糖尿病：该品种有较高发病率，需要定期检查血糖；眼部疾病：易患白内障、青光眼和睫毛倒生；心脏病：容易出现多种类型的心脏疾病；髋关节和肘关节发育不良：遗传性关节问题，可能导致关节炎；甲状腺功能减退：影响新陈代谢，需要定期检查；皮肤问题：容易出现皮肤感染和过敏反应；甲状旁腺功能亢进：老年犬常见，影响钙代谢；牙齿异常：可能出现牙齿缺失等问题',
    '因犬而异，需要了解个体差异',
    '中型',
    '10-15年',
    '待确认',
    '一般',
    '中',
    TRUE
);

INSERT INTO dog_breeds
(english_name, chinese_name, description, characteristics, common_diseases, temperament, size_category, life_expectancy, origin_country, care_level, exercise_needs, is_active)
VALUES (
    'komondor',
    '匈牙利牧羊犬',
    '匈牙利牧羊犬原产于匈牙利，是一种古老的牧羊犬品种，主要用于保护羊群和牛群免受狼、熊等捕食者的伤害。它们最显著的特征是全身覆盖着长长的白色绳状被毛，因此也被称为''拖把犬''。这种独特的被毛不仅可以保护它们免受恶劣天气和捕食者的伤害，还能让它们在羊群中伪装。它们性格勇敢、警觉，对家人非常忠诚，是优秀的护卫犬。',
    '体型：大型；身高：雄性69厘米以上，雌性65厘米以上；体重：雄性45-60公斤，雌性35-45公斤；寿命：10-12年；毛色：白色，带有绳状卷曲的长毛；性格特点：勇敢、忠诚、警觉、独立、保护欲强、冷静；运动需求：中等，每天需要适量运动；适应环境：适应户外生活，耐寒耐热；训练难度：较难训练，需要经验丰富的主人',
    '胃扭转：深胸犬种易患胃扭转，情况危急时可能在30分钟内致命；髋关节发育不良：遗传性疾病，可能导致关节炎和行动不便；肘关节发育不良：影响关节发育，可能导致跛行；眼部疾病：易患白内障和眼睑内翻；牙齿问题：容易出现牙齿异常，如咬合不正和乳牙滞留；肥胖：容易过重，需要控制饮食和保持运动；皮肤感染：长毛容易藏污纳垢，需要定期清理和护理；关节炎：大型犬常见，尤其是超重时更容易发生',
    '因犬而异，需要了解个体差异',
    '中型',
    '10-15年',
    '待确认',
    '一般',
    '中',
    TRUE
);

INSERT INTO dog_breeds
(english_name, chinese_name, description, characteristics, common_diseases, temperament, size_category, life_expectancy, origin_country, care_level, exercise_needs, is_active)
VALUES (
    'kuvasz',
    '库瓦兹犬',
    '库瓦兹犬原产于匈牙利，是一种古老的牧羊犬品种。它们最初由匈牙利贵族培育，用于保护牲畜和看守庄园。在15世纪末期，这种犬在匈牙利如此受重视，以至于只有贵族家庭才被允许饲养。它们以其优雅的外表、高度的智商和忠诚的性格而闻名。二战期间，由于其强烈的保护性，库瓦兹犬几乎灭绝，但后来通过专门的繁育计划得以恢复。',
    '体型：大型；身高：雄性66-76厘米，雌性61-71厘米；体重：雄性32-52公斤，雌性30-42公斤；寿命：10-12年；毛色：纯白色，双层被毛可以是直的或微微波浪状；性格特点：勇敢、忠诚、警觉、独立、保护欲强、温和；运动需求：需要大量运动，每天需要充分的活动；适应环境：适应户外生活，需要足够的活动空间；训练难度：较难训练，需要有经验的主人',
    '胃扭转：作为大型深胸犬种，容易发生胃扭转，需要及时治疗；髋关节发育不良：常见的遗传性骨骼问题，可能导致关节炎；肘关节发育不良：影响前肢关节发育，可能导致跛行；甲状腺功能减退：可能影响新陈代谢，需要定期检查；骨关节炎：大型犬常见问题，尤其是老年犬；眼部问题：可能出现白内障等遗传性眼病；皮肤问题：双层被毛需要定期护理，预防皮肤感染；心脏病：可能出现各种心脏问题，需要定期检查',
    '因犬而异，需要了解个体差异',
    '中型',
    '10-15年',
    '待确认',
    '一般',
    '中',
    TRUE
);

INSERT INTO dog_breeds
(english_name, chinese_name, description, characteristics, common_diseases, temperament, size_category, life_expectancy, origin_country, care_level, exercise_needs, is_active)
VALUES (
    'labrador_retriever',
    '拉布拉多寻回犬',
    '拉布拉多寻回犬原产于纽芬兰，而不是拉布拉多。它们最初是渔民的助手，帮助拖拉渔网和捕捉逃脱的鱼。19世纪初期被带到英国后，逐渐发展成为优秀的猎retrievers和家庭伴侣犬。自1991年以来，拉布拉多一直是美国最受欢迎的犬种。它们以其友善的性格、高智商和适应性强而闻名，不仅是优秀的家庭犬，还被广泛用作导盲犬、搜救犬、警犬和服务犬。',
    '体型：中大型；身高：雄性56-61厘米，雌性51-56厘米；体重：雄性27-36公斤，雌性25-32公斤；寿命：10-13年；毛色：黑色、黄色(奶油色到深金色)或巧克力色；性格特点：友善、聪明、活泼、忠诚、容易训练、适应性强；运动需求：需要大量运动，每天至少1-2小时；适应环境：适应性极强，适合家庭生活；训练难度：容易训练，学习能力强',
    '髋关节发育不良：遗传性疾病，可能导致关节炎和行动不便；肘关节发育不良：影响前肢关节发育，可能导致跛行；进行性视网膜萎缩：可能导致视力下降甚至失明；白内障：常见的眼部疾病，可能影响视力；耳部感染：由于耳朵下垂，容易积累湿气和碎屑导致感染；运动诱发性虚脱：剧烈运动后可能出现后肢无力和虚脱；中枢性肌病：遗传性疾病，影响肌肉功能；胃扭转：深胸犬种常见的急症，需要及时治疗；肥胖倾向：容易过度进食导致肥胖，需要控制饮食',
    '因犬而异，需要了解个体差异',
    '中型',
    '10-15年',
    '待确认',
    '一般',
    '中',
    TRUE
);