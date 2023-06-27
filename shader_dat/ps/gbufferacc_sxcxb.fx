float4 g_All_Offset;
float4 g_ColorEnhance;
sampler g_Color_1_sampler;
sampler g_Color_2_sampler;
samplerCUBE g_CubeSampler;
float4 g_GroundHemisphereColor;
float4 g_SkyHemisphereColor;
float4 g_ambientRate;
float4 g_cubeParam;
float4 g_cubeParam2;
float4 g_otherParam;

struct PS_IN
{
	float4 color : COLOR;
	float2 texcoord : TEXCOORD;
	float4 texcoord3 : TEXCOORD3;
	float3 texcoord4 : TEXCOORD4;
};

struct PS_OUT
{
	float4 color1 : COLOR1;
	float4 color2 : COLOR2;
	float4 color : COLOR;
};

PS_OUT main(PS_IN i)
{
	PS_OUT o;

	float4 r0;
	float4 r1;
	float4 r2;
	float4 r3;
	float3 r4;
	r0.xy = g_All_Offset.xy + i.texcoord.xy;
	r0 = tex2D(g_Color_1_sampler, r0);
	r1.x = r0.w + -0.01;
	r1 = r1.x + -g_otherParam.y;
	clip(r1);
	r1.xyz = normalize(i.texcoord3.xyz);
	o.color1.xyz = r1.xyz * 0.5 + 0.5;
	r1.x = g_cubeParam.z * r0.w + g_cubeParam.x;
	r2 = tex2D(g_CubeSampler, i.texcoord4);
	r1.yz = g_All_Offset.zw * i.texcoord.xy;
	r3 = tex2D(g_Color_2_sampler, r1.yzzw);
	r1.y = r3.w * -i.color.w + 1;
	r2 = r1.y * r2;
	r1.xyz = r1.xxx * r2.xyz;
	r1.xyz = r1.xyz * g_cubeParam.yyy;
	r2.xyz = r2.www * r1.xyz;
	r2.xyz = r2.xyz * g_cubeParam2.yyy;
	r1.xyz = r1.xyz * g_cubeParam2.xxx + r2.xyz;
	r1.w = r3.w * i.color.w;
	r2.xyz = lerp(r3.xyz, r0.xyz, r1.www);
	r3.xyz = g_ColorEnhance.xyz * i.color.xyz;
	r4.xyz = r2.xyz * r3.xyz + g_cubeParam2.zzz;
	r0.xyz = r2.xyz * r3.xyz;
	r1.xyz = r1.xyz * r4.xyz;
	r1.w = 0.1 + -i.texcoord3.w;
	r2.xyz = r1.www * g_GroundHemisphereColor.xyz;
	r1.w = 0.1 + i.texcoord3.w;
	r2.xyz = g_SkyHemisphereColor.xyz * r1.www + r2.xyz;
	r2.xyz = r2.xyz + g_ambientRate.xyz;
	o.color2.xyz = r2.xyz * r0.xyz + r1.xyz;
	o.color = r0;
	o.color2.w = r0.w;
	o.color1.w = g_otherParam.x;

	return o;
}
