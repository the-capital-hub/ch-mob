import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:get/get.dart';

class ResourceController extends GetxController{

  final List<String> menuTemplatesName=['GTM Strategy','Sales & Marketing Plans', 'Pitch Deck','Financial Modeling'];

  final List<String> menuTemplateIcons=[PngAssetPath.gtmStrategyImg,PngAssetPath.salesImg,
    PngAssetPath.pickDeckImg, PngAssetPath.financialImg
  ];

  final List<String> menuItemsName=['Sales Playbook','Marketing Playbook',
    'Go-to-Market Strategy','Pitch Deck Playbook','Financial Modeling Playbook'];

  final List<String> menuItemsIcons=[PngAssetPath.salesImg,PngAssetPath.marketingImg,PngAssetPath.gtmStrategyImg,
    PngAssetPath.pickDeckImg,PngAssetPath.financialImg
  ];
}