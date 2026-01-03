--[=[
	@class Types
]=]

--[=[
	@type AuthCondition (player: Player) -> boolean
	@within Types
]=]
export type AuthCondition = (player: Player) -> boolean

--[=[
	A string which represents policies returned by [PolicyService.GetPolicyInfoForPlayerAsync](https://create.roblox.com/docs/reference/engine/classes/PolicyService#GetPolicyInfoForPlayerAsync).

	@type Policy "AreAdsAllowed" | "ArePaidRandomItemsRestricted" | "AllowedExternalLinkReferences" | "IsContentSharingAllowed" | "IsEligibleToPurchaseCommerceProduct" | "IsEligibleToPurchaseSubscription" | "IsPaidItemTradingAllowed" | "IsPhotoToAvatarAllowed" | "IsSubjectToChinaPolicies"
	@within Types
]=]
export type Policy = 
    "AreAdsAllowed" |
    "ArePaidRandomItemsRestricted" |
    "AllowedExternalLinkReferences" |
    "IsContentSharingAllowed" |
    "IsEligibleToPurchaseCommerceProduct" |
    "IsEligibleToPurchaseSubscription" |
    "IsPaidItemTradingAllowed" |
    "IsPhotoToAvatarAllowed" |
    "IsSubjectToChinaPolicies"

return {}