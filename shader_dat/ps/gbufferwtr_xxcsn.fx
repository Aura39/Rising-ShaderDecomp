float4 g_All_Offset;
float4 g_BlurParam;
sampler g_Color_1_sampler;
samplerCUBE g_CubeSampler;
sampler g_Normalmap2_sampler;
sampler g_Normalmap_sampler;
float4 g_ambientRate;
float4 g_cubeParam;
float4 g_cubeParam2;
float3 g_lightDir;
float4 g_normalmapRate;
float4 g_otherParam;
float4 g_specParam;

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float3 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
	float3 texcoord3 : TEXCOORD3;
	float3 texcoord4 : TEXCOORD4;
	float3 texcoord5 : TEXCOORD5;
	float3 texcoord6 : TEXCOORD6;
	float4 texcoord7 : TEXCOORD7;
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
	float4 r3;
	float3 r4;
	float3 r5;
	r0.xyz = g_normalmapRate.xyz;
	r0.yz = i.texcoord.xy * r0.yz + g_All_Offset.xy;
	r1 = tex2D(g_Normalmap_sampler, r0.yzzw);
	r2.xy = g_otherParam.xy;
	r0.yz = i.texcoord.xy * r2.xy + g_All_Offset.xy;
	r3 = tex2D(g_Normalmap2_sampler, r0.yzzw);
	r0.yzw = r1.xyz + r3.xyz;
	r1.xyz = normalize(r0.yzw);
	r0.y = r1.x * 2 + -1;
	r1.yz = r1.yz * -2 + float2(-2, 1);
	r0.z = 1 + -i.texcoord2.w;
	r0.z = -r0.z + 1;
	r1.x = r0.z * r0.y;
	r0.yzw = r1.xyz * g_normalmapRate.xxx;
	r1.xyz = normalize(i.texcoord2.xyz);
	r3.xyz = normalize(i.texcoord3.xyz);
	r2.yzw = r1.zxy * r3.yzx;
	r2.yzw = r1.yzx * r3.zxy + -r2.yzw;
	r2.yzw = r0.zzz * r2.yzw;
	r1.xyz = r0.yyy * r1.xyz + r2.yzw;
	r1.xyz = r0.www * r3.xyz + r1.xyz;
	r1.w = dot(g_lightDir.xyz, r3.xyz);
	r3.xyz = normalize(r1.xyz);
	o.color1.xyz = r3.xyz * 0.5 + 0.5;
	o.color1.w = r2.x + g_specParam.y;
	r1.x = 1 / i.texcoord7.z;
	r1.xy = r1.xx * i.texcoord8.xy;
	r1.z = 1 / i.texcoord7.w;
	r1.xy = i.texcoord7.xy * r1.zz + -r1.xy;
	r2.w = 0.5;
	o.color3.xy = r1.xy * g_BlurParam.xy + r2.ww;
	r1.xyz = i.texcoord4.xyz;
	r2.xyz = r1.zxy * i.texcoord5.yzx;
	r1.xyz = r1.yzx * i.texcoord5.zxy + -r2.xyz;
	r1.xyz = r0.zzz * r1.xyz;
	r1.xyz = r0.yyy * i.texcoord4.xyz + r1.xyz;
	r0.yzw = r0.www * i.texcoord5.xyz + r1.xyz;
	r1.x = dot(i.texcoord6.xyz, r0.yzw);
	r1.x = r1.x + r1.x;
	r2.xyz = r0.yzw * -r1.xxx + i.texcoord6.xyz;
	r2.w = -r2.z;
	r2 = tex2D(g_CubeSampler, r2.xyww);
	r0.yz = r2.ww * g_cubeParam2.zw + g_cubeParam2.xy;
	r1.xyz = normalize(-i.texcoord1.xyz);
	r0.w = dot(r1.xyz, r3.xyz);
	r1.x = dot(g_lightDir.xyz, r3.xyz);
	r1.x = -r1.w + r1.x;
	r0.x = r1.x * r0.x + 1;
	r1.x = pow(r0.w, g_otherParam.w);
	r0.w = r1.x + 0.2;
	r1.x = -r1.x + 0.01;
	r0.w = 1 / r0.w;
	r0.w = (r1.x >= 0) ? 4.7619047 : r0.w;
	r1.yzw = float3(2, -1, 1);
	r1.x = (-g_cubeParam.w >= 0) ? -r1.w : -r1.y;
	r3.x = (g_cubeParam.w >= 0) ? r1.w : r1.y;
	r1.x = r1.x + r3.x;
	r1.z = r1.z + -g_cubeParam.w;
	r3 = tex2D(g_Color_1_sampler, i.texcoord8.zwzw);
	r1.x = r3.w * r1.x + r1.z;
	r2.xyz = r1.xxx * r2.xyz;
	r2.xyz = r2.xyz * g_cubeParam.yyy;
	r4.xyz = r2.xyz * r0.www + -r2.xyz;
	r2.xyz = r2.www * r4.xyz + r2.xyz;
	r4.xyz = r0.yyy * r2.xyz;
	r2.xyz = r2.xyz * r3.xyz;
	r5.xyz = r3.xyz * g_ambientRate.xyz;
	o.color.xyz = r3.xyz;
	r0.xyw = r5.xyz * r0.xxx + r4.xyz;
	o.color2.xyz = r2.xyz * r0.zzz + r0.xyw;
	o.color.w = 1;
	o.color2.w = 0;
	o.color3.zw = -r1.wy * g_specParam.zz;

	return o;
}
