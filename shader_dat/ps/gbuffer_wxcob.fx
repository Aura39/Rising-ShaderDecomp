float4 g_All_Offset : register(c49);
float4 g_ColorEnhance : register(c50);
sampler g_Color_1_sampler : register(s0);
sampler g_Color_2_sampler : register(s1);
samplerCUBE g_CubeSampler : register(s3);
float4 g_GroundHemisphereColor : register(c190);
sampler g_Normalmap_sampler : register(s4);
sampler g_OcclusionSampler : register(s2);
float4 g_SkyHemisphereColor : register(c189);
float4 g_ambientRate : register(c191);
float4 g_cubeParam : register(c42);
float4 g_cubeParam2 : register(c43);
float4 g_lightColor : register(c47);
float3 g_lightDir : register(c46);
float4 g_normalmapRate : register(c44);
float4 g_olcParam : register(c48);
float4 g_otherParam : register(c45);

struct PS_IN
{
	float4 color : COLOR;
	float4 texcoord : TEXCOORD;
	float3 texcoord1 : TEXCOORD1;
	float4 texcoord3 : TEXCOORD3;
	float3 texcoord4 : TEXCOORD4;
	float4 texcoord8 : TEXCOORD8;
};

struct PS_OUT
{
	float4 color : COLOR;
	float4 color1 : COLOR1;
	float4 color2 : COLOR2;
	float4 color3 : COLOR3;
};

PS_OUT main(PS_IN i)
{
	PS_OUT o;

	float4 r0;
	float4 r1;
	float4 r2;
	float3 r3;
	float3 r4;
	float4 r5;
	r0.xy = g_All_Offset.xy + i.texcoord.xy;
	r0 = tex2D(g_Color_1_sampler, r0);
	r1 = r0.w + -g_otherParam.y;
	clip(r1);
	r1 = tex2D(g_Normalmap_sampler, i.texcoord8.zwzw);
	r1.xyz = r1.xyz + -1;
	r1.w = abs(g_normalmapRate.x);
	r1.xyz = r1.www * r1.xyz + 1;
	r2.xy = g_All_Offset.zw * i.texcoord.xy;
	r2 = tex2D(g_Color_2_sampler, r2);
	r1.w = r2.w * i.color.w;
	r3.xyz = lerp(r2.xyz, r0.xyz, r1.www);
	r0.x = g_cubeParam.z * r0.w + g_cubeParam.x;
	r0.y = r2.w * -i.color.w + 1;
	r1.xyz = r1.xyz * r3.xyz;
	r2.xyz = g_ColorEnhance.xyz * i.color.xyz;
	r3.xyz = r1.xyz * r2.xyz;
	r1.xyz = r1.xyz * r2.xyz + g_cubeParam2.zzz;
	r2 = tex2D(g_OcclusionSampler, i.texcoord.zwzw);
	r4.xyz = -r2.xyw + 1;
	r2.xyz = g_ambientRate.www * r4.xyz + r2.xyw;
	o.color.xyz = r2.zzz * r3.xyz;
	r4.xyz = normalize(i.texcoord3.xyz);
	o.color1.xyz = r4.xyz * 0.5 + 0.5;
	r5 = tex2D(g_CubeSampler, i.texcoord4);
	r5 = r0.y * r5;
	r0.x = g_cubeParam.w * r2.y + r0.x;
	r0.xyz = r0.xxx * r5.xyz;
	r0.xyz = r0.xyz * g_cubeParam.yyy;
	r2.yzw = r5.www * r0.xyz;
	r2.yzw = r2.yzw * g_cubeParam2.yyy;
	r0.xyz = r0.xyz * g_cubeParam2.xxx + r2.yzw;
	r0.xyz = r1.xyz * r0.xyz;
	r0.w = r2.x * 0.5 + 0.5;
	r0.w = r0.w * r0.w;
	r0.xyz = r0.www * r0.xyz;
	r1.xyz = r2.xxx * r3.xyz;
	r2.yzw = r3.xyz * g_lightColor.xyz;
	o.color.w = r2.x;
	r0.w = 0.1 + -i.texcoord3.w;
	r3.xyz = r0.www * g_GroundHemisphereColor.xyz;
	r0.w = 0.1 + i.texcoord3.w;
	r3.xyz = g_SkyHemisphereColor.xyz * r0.www + r3.xyz;
	r3.xyz = r3.xyz + g_ambientRate.xyz;
	r1.xyz = r1.xyz * r3.xyz;
	r0.w = dot(g_lightDir.xyz, r4.xyz);
	r0.w = r0.w + 0.5;
	r1.w = frac(r0.w);
	r0.w = r0.w + -r1.w;
	r1.w = r0.w + g_olcParam.x;
	r0.w = -r0.w + 1;
	r0.xyz = r1.xyz * r1.www + r0.xyz;
	r1.xyz = normalize(-i.texcoord1.xyz);
	r1.x = dot(r1.xyz, r4.xyz);
	r1.z = 0.5;
	r1.x = r1.x * g_olcParam.w + r1.z;
	r1.y = frac(r1.x);
	r1.x = -r1.y + r1.x;
	r1.y = r1.z + g_olcParam.y;
	r1.z = frac(r1.y);
	r1.y = -r1.z + r1.y;
	r1.y = 1 / r1.y;
	r1.x = r1.x * -r1.y + 1;
	r1.x = r1.x * g_olcParam.z;
	r0.w = r0.w * r1.x;
	o.color2.xyz = r2.yzw * r0.www + r0.xyz;
	o.color1.w = g_otherParam.x;
	o.color2.w = g_otherParam.z;
	r0.w = g_ambientRate.w;
	o.color3.xzw = r0.www * float3(-1, 0, 0) + float3(1, 0, 0);
	o.color3.y = g_cubeParam2.w;

	return o;
}
