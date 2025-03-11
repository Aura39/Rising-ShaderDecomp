float4 g_All_Offset : register(c49);
float4 g_ColorEnhance : register(c50);
sampler g_Color_1_sampler : register(s0);
sampler g_Color_2_sampler : register(s1);
float4 g_GroundHemisphereColor : register(c190);
sampler g_OcclusionSampler : register(s2);
float4 g_SkyHemisphereColor : register(c189);
float4 g_ambientRate : register(c191);
float4 g_otherParam : register(c45);

struct PS_IN
{
	float4 color : COLOR;
	float4 texcoord : TEXCOORD;
	float4 texcoord3 : TEXCOORD3;
};

struct PS_OUT
{
	float4 color1 : COLOR1;
	float4 color : COLOR;
	float4 color2 : COLOR2;
};

PS_OUT main(PS_IN i)
{
	PS_OUT o;

	float4 r0;
	float4 r1;
	float3 r2;
	r0.xy = g_All_Offset.xy + i.texcoord.xy;
	r0 = tex2D(g_Color_1_sampler, r0);
	r1.x = r0.w + -0.01;
	r1 = r1.x + -g_otherParam.y;
	clip(r1);
	r1.xyz = normalize(i.texcoord3.xyz);
	o.color1.xyz = r1.xyz * 0.5 + 0.5;
	r1.xy = g_All_Offset.zw * i.texcoord.xy;
	r1 = tex2D(g_Color_2_sampler, r1);
	r1.w = r1.w * i.color.w;
	r2.xyz = lerp(r1.xyz, r0.xyz, r1.www);
	r1.xyz = g_ColorEnhance.xyz * i.color.xyz;
	r0.xyz = r1.xyz * r2.xyz;
	r1 = tex2D(g_OcclusionSampler, i.texcoord.zwzw);
	r1.y = -r1.x + 1;
	r1.x = g_ambientRate.w * r1.y + r1.x;
	r1.xyz = r0.xyz * r1.xxx;
	o.color = r0;
	o.color2.w = r0.w;
	r0.x = 0.1 + -i.texcoord3.w;
	r0.xyz = r0.xxx * g_GroundHemisphereColor.xyz;
	r0.w = 0.1 + i.texcoord3.w;
	r0.xyz = g_SkyHemisphereColor.xyz * r0.www + r0.xyz;
	r0.xyz = r0.xyz + g_ambientRate.xyz;
	o.color2.xyz = r1.xyz * r0.xyz;
	o.color1.w = g_otherParam.x;

	return o;
}
