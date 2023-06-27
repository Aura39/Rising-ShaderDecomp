float4 g_All_Offset;
float4 g_ColorEnhance;
sampler g_Color_1_sampler;
samplerCUBE g_CubeSampler;
float4 g_GroundHemisphereColor;
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
	float3 color : COLOR;
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
	float3 r4;
	r0.xy = g_All_Offset.xy + i.texcoord.xy;
	r0 = tex2D(g_Color_1_sampler, r0);
	r1.x = r0.w + -0.01;
	r1 = r1.x + -g_otherParam.y;
	clip(r1);
	r1.xyz = normalize(i.texcoord3.xyz);
	o.color1.xyz = r1.xyz * 0.5 + 0.5;
	r1.x = g_cubeParam.z * r0.w + g_cubeParam.x;
	r2 = tex2D(g_OcclusionSampler, i.texcoord.zwzw);
	r1.yz = -r2.xy + 1;
	r1.yz = g_ambientRate.ww * r1.yz + r2.xy;
	r1.x = g_cubeParam.w * r1.z + r1.x;
	r2 = tex2D(g_CubeSampler, i.texcoord4);
	r1.xzw = r1.xxx * r2.xyz;
	r1.xzw = r1.xzw * g_cubeParam.yyy;
	r2.xyz = r2.www * r1.xzw;
	r2.xyz = r2.xyz * g_cubeParam2.yyy;
	r1.xzw = r1.xzw * g_cubeParam2.xxx + r2.xyz;
	r2 = tex2D(g_Normalmap_sampler, i.texcoord8.zwzw);
	r2.xyz = r2.xyz + -1;
	r2.w = abs(g_normalmapRate.x);
	r2.xyz = r2.www * r2.xyz + 1;
	r2.xyz = r0.xyz * r2.xyz;
	r3.xyz = g_ColorEnhance.xyz * i.color.xyz;
	r4.xyz = r2.xyz * r3.xyz + g_cubeParam2.zzz;
	r0.xyz = r2.xyz * r3.xyz;
	r1.xzw = r1.xzw * r4.xyz;
	r2.x = r1.y * 0.5 + 0.5;
	r2.yzw = r1.yyy * r0.xyz;
	o.color = r0;
	o.color2.w = r0.w;
	r0.x = r2.x * r2.x;
	r0.xyz = r0.xxx * r1.xzw;
	r0.w = 0.1 + -i.texcoord3.w;
	r1.xyz = r0.www * g_GroundHemisphereColor.xyz;
	r0.w = 0.1 + i.texcoord3.w;
	r1.xyz = g_SkyHemisphereColor.xyz * r0.www + r1.xyz;
	r1.xyz = r1.xyz + g_ambientRate.xyz;
	o.color2.xyz = r1.xyz * r2.yzw + r0.xyz;
	o.color1.w = g_otherParam.x;

	return o;
}
