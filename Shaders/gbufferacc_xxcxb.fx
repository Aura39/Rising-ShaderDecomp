float4 g_All_Offset;
float4 g_ColorEnhance;
sampler g_Color_1_sampler;
sampler g_Color_2_sampler;
samplerCUBE g_CubeSampler;
float4 g_GroundHemisphereColor;
sampler g_Normalmap_sampler;
float4 g_SkyHemisphereColor;
float4 g_ambientRate;
float4 g_cubeParam;
float4 g_cubeParam2;
float3 g_lightDir;
float4 g_normalmapRate;
float4 g_otherParam;

struct PS_IN
{
	float4 color : COLOR;
	float2 texcoord : TEXCOORD;
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
	float4 color : COLOR;
	float4 color2 : COLOR2;
};

PS_OUT main(PS_IN i)
{
	PS_OUT o;

	float4 r0;
	float4 r1;
	float4 r2;
	float4 r3;
	float4 r4;
	float3 r5;
	r0.xy = g_All_Offset.xy + i.texcoord.xy;
	r0 = tex2D(g_Color_1_sampler, r0);
	r1.x = r0.w + -0.01;
	r1 = r1.x + -g_otherParam.y;
	clip(r1);
	r1.xyz = normalize(i.texcoord2.xyz);
	r2.xyz = normalize(i.texcoord3.xyz);
	r3.xyz = r1.zxy * r2.yzx;
	r3.xyz = r1.yzx * r2.zxy + -r3.xyz;
	r4 = tex2D(g_Normalmap_sampler, i.texcoord8.zwzw);
	r4.xyz = r4.xyz * 2 + -1;
	r5.x = r4.x * i.texcoord2.w;
	r5.yz = r4.yz * float2(2, -1);
	r4.xyz = r5.xyz * g_normalmapRate.xxx;
	r5.xyz = normalize(r4.xyz);
	r3.xyz = r3.xyz * r5.yyy;
	r1.xyz = r5.xxx * r1.xyz + r3.xyz;
	r1.xyz = r5.zzz * r2.xyz + r1.xyz;
	r1.w = dot(g_lightDir.xyz, r2.xyz);
	r2.xyz = normalize(r1.xyz);
	o.color1.xyz = r2.xyz * 0.5 + 0.5;
	r1.x = dot(g_lightDir.xyz, r2.xyz);
	r1.x = -r1.w + r1.x;
	r1.x = r1.x + 1;
	r2.xyz = i.texcoord4.xyz;
	r1.yzw = r2.zxy * i.texcoord5.yzx;
	r1.yzw = r2.yzx * i.texcoord5.zxy + -r1.yzw;
	r1.yzw = r1.yzw * r5.yyy;
	r1.yzw = r5.xxx * i.texcoord4.xyz + r1.yzw;
	r1.yzw = r5.zzz * i.texcoord5.xyz + r1.yzw;
	r2.x = dot(i.texcoord6.xyz, r1.yzw);
	r2.x = r2.x + r2.x;
	r2.xyz = r1.yzw * -r2.xxx + i.texcoord6.xyz;
	r2.w = -r2.z;
	r2 = tex2D(g_CubeSampler, r2.xyww);
	r1.yz = g_All_Offset.zw * i.texcoord.xy;
	r3 = tex2D(g_Color_2_sampler, r1.yzzw);
	r1.y = r3.w * -i.color.w + 1;
	r2 = r1.y * r2;
	r1.y = g_cubeParam.z * r0.w + g_cubeParam.x;
	r1.y = r1.y + g_cubeParam.w;
	r1.yzw = r1.yyy * r2.xyz;
	r1.yzw = r1.yzw * g_cubeParam.yyy;
	r2.xyz = r2.www * r1.yzw;
	r2.xyz = r2.xyz * g_cubeParam2.yyy;
	r1.yzw = r1.yzw * g_cubeParam2.xxx + r2.xyz;
	r2.x = r3.w * i.color.w;
	r4.xyz = lerp(r3.xyz, r0.xyz, r2.xxx);
	r2.xyz = g_ColorEnhance.xyz * i.color.xyz;
	r3.xyz = r4.xyz * r2.xyz + g_cubeParam2.zzz;
	r0.xyz = r2.xyz * r4.xyz;
	r1.yzw = r1.yzw * r3.xyz;
	r2.x = 0.1 + -i.texcoord3.w;
	r2.xyz = r2.xxx * g_GroundHemisphereColor.xyz;
	r2.w = 0.1 + i.texcoord3.w;
	r2.xyz = g_SkyHemisphereColor.xyz * r2.www + r2.xyz;
	r2.xyz = r2.xyz + g_ambientRate.xyz;
	r2.xyz = r0.xyz * r2.xyz;
	o.color = r0;
	o.color2.w = r0.w;
	o.color2.xyz = r2.xyz * r1.xxx + r1.yzw;
	o.color1.w = g_otherParam.x;

	return o;
}
