float4 g_All_Offset : register(c49);
float4 g_ColorEnhance : register(c50);
sampler g_Color_1_sampler : register(s0);
sampler g_Color_2_sampler : register(s1);
samplerCUBE g_CubeSampler : register(s3);
float4 g_GroundHemisphereColor : register(c190);
sampler g_Normalmap_sampler : register(s4);
float4 g_SkyHemisphereColor : register(c189);
float4 g_ambientRate : register(c191);
float4 g_cubeParam : register(c42);
float4 g_cubeParam2 : register(c43);
float4 g_lightColor : register(c47);
float3 g_lightDir : register(c46);
float4 g_normalmapRate : register(c44);
float4 g_olcParam : register(c48);
float4 g_otherParam : register(c45);
float4 g_specParam : register(c41);

struct PS_IN
{
	float4 color : COLOR;
	float2 texcoord : TEXCOORD;
	float3 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
	float4 texcoord3 : TEXCOORD3;
	float3 texcoord4 : TEXCOORD4;
	float3 texcoord5 : TEXCOORD5;
	float3 texcoord6 : TEXCOORD6;
	float4 texcoord8 : TEXCOORD8;
};

struct PS_OUT
{
	float4 color1 : COLOR1;
	float4 color3 : COLOR3;
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
	float3 r5;
	r0.xy = g_All_Offset.xy + i.texcoord.xy;
	r0 = tex2D(g_Color_1_sampler, r0);
	r1 = r0.w + -g_otherParam.y;
	clip(r1);
	r1.xyz = normalize(i.texcoord2.xyz);
	r2.xyz = normalize(i.texcoord3.xyz);
	r3.xyz = r1.zxy * r2.yzx;
	r3.xyz = r1.yzx * r2.zxy + -r3.xyz;
	r4 = tex2D(g_Normalmap_sampler, i.texcoord8.zwzw);
	r4.xyz = r4.xyz * 2 + -1;
	r1.w = lerp(r4.w, r0.w, g_specParam.w);
	r1.w = dot(r1.www, 0.298912);
	r5.x = r4.x * i.texcoord2.w;
	r5.yz = r4.yz * float2(2, -1);
	r4.xyz = r5.xyz * g_normalmapRate.xxx;
	r5.xyz = normalize(r4.xyz);
	r3.xyz = r3.xyz * r5.yyy;
	r1.xyz = r5.xxx * r1.xyz + r3.xyz;
	r1.xyz = r5.zzz * r2.xyz + r1.xyz;
	r2.x = dot(g_lightDir.xyz, r2.xyz);
	r3.xyz = normalize(r1.xyz);
	o.color1.xyz = r3.xyz * 0.5 + 0.5;
	r1.x = -g_specParam.x;
	r1.x = (-r1.x >= 0) ? 0 : 0.25;
	r4.x = g_otherParam.x;
	r1.y = r4.x + g_specParam.y;
	o.color1.w = r1.x + r1.y;
	r1.x = abs(g_specParam.x);
	o.color3.z = r1.x * r1.w;
	r1.xyz = i.texcoord4.xyz;
	r2.yzw = r1.zxy * i.texcoord5.yzx;
	r1.xyz = r1.yzx * i.texcoord5.zxy + -r2.yzw;
	r1.xyz = r1.xyz * r5.yyy;
	r1.xyz = r5.xxx * i.texcoord4.xyz + r1.xyz;
	r1.xyz = r5.zzz * i.texcoord5.xyz + r1.xyz;
	r1.w = dot(i.texcoord6.xyz, r1.xyz);
	r1.w = r1.w + r1.w;
	r1.xyz = r1.xyz * -r1.www + i.texcoord6.xyz;
	r1.w = -r1.z;
	r1 = tex2D(g_CubeSampler, r1.xyww);
	r2.yz = g_All_Offset.zw * i.texcoord.xy;
	r4 = tex2D(g_Color_2_sampler, r2.yzzw);
	r2.y = r4.w * -i.color.w + 1;
	r1 = r1 * r2.y;
	r0.w = g_cubeParam.z * r0.w + g_cubeParam.x;
	r0.w = r0.w + g_cubeParam.w;
	r1.xyz = r0.www * r1.xyz;
	r1.xyz = r1.xyz * g_cubeParam.yyy;
	r2.yzw = r1.www * r1.xyz;
	r2.yzw = r2.yzw * g_cubeParam2.yyy;
	r1.xyz = r1.xyz * g_cubeParam2.xxx + r2.yzw;
	r0.w = r4.w * i.color.w;
	r2.yzw = lerp(r4.xyz, r0.xyz, r0.www);
	r0.xyz = g_ColorEnhance.xyz * i.color.xyz;
	r4.xyz = r2.yzw * r0.xyz + g_cubeParam2.zzz;
	r0.xyz = r0.xyz * r2.yzw;
	r1.xyz = r1.xyz * r4.xyz;
	r0.w = dot(g_lightDir.xyz, r3.xyz);
	r1.w = -r2.x + r0.w;
	r0.w = r0.w;
	r0.w = r0.w + 0.5;
	r1.w = r1.w + 1;
	r2.x = 0.1 + -i.texcoord3.w;
	r2.xyz = r2.xxx * g_GroundHemisphereColor.xyz;
	r2.w = 0.1 + i.texcoord3.w;
	r2.xyz = g_SkyHemisphereColor.xyz * r2.www + r2.xyz;
	r2.xyz = r2.xyz + g_ambientRate.xyz;
	r2.xyz = r0.xyz * r2.xyz;
	r2.xyz = r1.www * r2.xyz;
	r1.w = frac(r0.w);
	r0.w = r0.w + -r1.w;
	r1.w = r0.w + g_olcParam.x;
	r0.w = -r0.w + 1;
	r1.xyz = r2.xyz * r1.www + r1.xyz;
	r2.xyz = normalize(-i.texcoord1.xyz);
	r1.w = dot(r2.xyz, r3.xyz);
	r2.zw = float2(2, -1);
	r1.w = r1.w * g_olcParam.w + r2.w;
	r2.x = frac(r1.w);
	r1.w = r1.w + -r2.x;
	r2.x = r2.w + g_olcParam.y;
	r2.y = frac(r2.x);
	r2.x = -r2.y + r2.x;
	r2.x = 1 / r2.x;
	r1.w = r1.w * -r2.x + 1;
	r1.w = r1.w * g_olcParam.z;
	r0.w = r0.w * r1.w;
	r2.xyw = r0.xyz * g_lightColor.xyz;
	o.color.xyz = r0.xyz;
	o.color2.xyz = r2.xyw * r0.www + r1.xyz;
	o.color.w = 1;
	o.color2.w = g_otherParam.z;
	o.color3.x = r2.z + -g_ambientRate.w;
	o.color3.y = g_cubeParam2.w;
	o.color3.w = g_specParam.z;

	return o;
}
