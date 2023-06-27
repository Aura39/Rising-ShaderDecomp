float4 g_All_Offset;
float4 g_ColorEnhance;
sampler g_Color_1_sampler;
sampler g_Color_2_sampler;
samplerCUBE g_CubeSampler;
float4 g_GroundHemisphereColor;
sampler g_MaskSampler;
sampler g_Normalmap_sampler;
sampler g_OcclusionSampler;
float4 g_SkyHemisphereColor;
float4 g_ambientRate;
float4 g_cubeParam;
float4 g_cubeParam2;
float4 g_normalmapRate;
float4 g_otherParam;

struct PS_IN
{
	float4 color : COLOR;
	float4 texcoord : TEXCOORD;
	float4 texcoord3 : TEXCOORD3;
	float3 texcoord4 : TEXCOORD4;
	float4 texcoord8 : TEXCOORD8;
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
	float3 r3;
	float4 r4;
	r0.xy = g_All_Offset.xy + i.texcoord.xy;
	r0 = tex2D(g_Color_1_sampler, r0);
	r1.x = r0.w + -0.01;
	r1 = r1.x + -g_otherParam.y;
	clip(r1);
	r1.xyz = normalize(i.texcoord3.xyz);
	o.color1.xyz = r1.xyz * 0.5 + 0.5;
	r1 = tex2D(g_Normalmap_sampler, i.texcoord8.zwzw);
	r1.xyz = r1.xyz + -1;
	r1.w = abs(g_normalmapRate.x);
	r1.xyz = r1.www * r1.xyz + 1;
	r2.xy = g_All_Offset.zw * i.texcoord.xy;
	r2 = tex2D(g_Color_2_sampler, r2);
	r1.w = r2.w * i.color.w;
	r3.xyz = lerp(r2.xyz, r0.xyz, r1.www);
	r1.w = r2.w * -i.color.w + 1;
	r1.xyz = r1.xyz * r3.xyz;
	r2.xyz = g_ColorEnhance.xyz * i.color.xyz;
	r3.xyz = r1.xyz * r2.xyz + g_cubeParam2.zzz;
	r0.xyz = r1.xyz * r2.xyz;
	r2 = tex2D(g_CubeSampler, i.texcoord4);
	r1 = r1.w * r2;
	r2 = tex2D(g_MaskSampler, i.texcoord8.zwzw);
	r2.xyz = g_cubeParam.zzz * r2.xyz + g_cubeParam.xxx;
	r4 = tex2D(g_OcclusionSampler, i.texcoord.zwzw);
	r4.zw = -r4.xy + 1;
	r4.xy = g_ambientRate.ww * r4.zw + r4.xy;
	r2.xyz = g_cubeParam.www * r4.yyy + r2.xyz;
	r1.xyz = r1.xyz * r2.xyz;
	r1.xyz = r1.xyz * g_cubeParam.yyy;
	r2.xyz = r1.www * r1.xyz;
	r2.xyz = r2.xyz * g_cubeParam2.yyy;
	r1.xyz = r1.xyz * g_cubeParam2.xxx + r2.xyz;
	r1.xyz = r3.xyz * r1.xyz;
	r1.w = r4.x * 0.5 + 0.5;
	r2.xyz = r0.xyz * r4.xxx;
	o.color = r0;
	o.color2.w = r0.w;
	r0.x = r1.w * r1.w;
	r0.xyz = r0.xxx * r1.xyz;
	r0.w = 0.1 + -i.texcoord3.w;
	r1.xyz = r0.www * g_GroundHemisphereColor.xyz;
	r0.w = 0.1 + i.texcoord3.w;
	r1.xyz = g_SkyHemisphereColor.xyz * r0.www + r1.xyz;
	r1.xyz = r1.xyz + g_ambientRate.xyz;
	o.color2.xyz = r1.xyz * r2.xyz + r0.xyz;
	o.color1.w = g_otherParam.x;

	return o;
}
