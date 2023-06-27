float4 g_All_Offset;
float4 g_ColorEnhance;
sampler g_Color_1_sampler;
float4 g_GroundHemisphereColor;
sampler g_OcclusionSampler;
float4 g_SkyHemisphereColor;
float4 g_ambientRate;
float4 g_otherParam;

struct PS_IN
{
	float3 color : COLOR;
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
	float4 r2;
	r0.xy = g_All_Offset.xy + i.texcoord.xy;
	r0 = tex2D(g_Color_1_sampler, r0);
	r1.x = r0.w + -0.01;
	r1 = r1.x + -g_otherParam.y;
	clip(r1);
	r1.xyz = normalize(i.texcoord3.xyz);
	o.color1.xyz = r1.xyz * 0.5 + 0.5;
	r1.x = 0.1 + -i.texcoord3.w;
	r1.xyz = r1.xxx * g_GroundHemisphereColor.xyz;
	r1.w = 0.1 + i.texcoord3.w;
	r1.xyz = g_SkyHemisphereColor.xyz * r1.www + r1.xyz;
	r1.xyz = r1.xyz + g_ambientRate.xyz;
	r2 = tex2D(g_OcclusionSampler, i.texcoord.zwzw);
	r1.w = -r2.x + 1;
	r1.w = g_ambientRate.w * r1.w + r2.x;
	r2.xyz = g_ColorEnhance.xyz * i.color.xyz;
	r0.xyz = r0.xyz * r2.xyz;
	r2.xyz = r1.www * r0.xyz;
	o.color = r0;
	o.color2.w = r0.w;
	o.color2.xyz = r1.xyz * r2.xyz;
	o.color1.w = g_otherParam.x;

	return o;
}
