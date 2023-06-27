float4 Incidence_param;
float4 g_All_Offset;
float4 g_BlurParam;
sampler g_Color_1_sampler;
float4 g_NormalWeightParam;
sampler g_Normalmap2_sampler;
sampler g_Normalmap_sampler;
sampler g_OcclusionSampler;
float4 g_WeightParam;
float4 g_ambientRate;
sampler g_incidence_sampler;
float3 g_lightDir;
float4 g_normalmapRate;
float4 g_otherParam;
float4 g_specParam;
sampler g_wightmap_sampler;

struct PS_IN
{
	float4 texcoord : TEXCOORD;
	float3 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
	float3 texcoord3 : TEXCOORD3;
	float4 texcoord7 : TEXCOORD7;
	float2 texcoord8 : TEXCOORD8;
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
	float4 r3;
	float3 r4;
	float4 r5;
	float4 r6;
	float3 r7;
	r0.xy = lerp(i.texcoord.zw, i.texcoord.xy, g_NormalWeightParam.zz);
	r1.xyz = g_normalmapRate.xyz;
	r0.zw = r0.xy * r1.yz + g_All_Offset.xy;
	r2 = tex2D(g_Normalmap2_sampler, r0.zwzw);
	r1.yzw = lerp(r2.zwz, r2.xyz, g_NormalWeightParam.yyy);
	r2 = tex2D(g_wightmap_sampler, r0.zwzw);
	r3 = tex2D(g_Normalmap_sampler, r0.zwzw);
	r0.z = dot(r2.xyz, g_WeightParam.xyz);
	r0.w = r0.z * g_NormalWeightParam.x;
	r2.x = 1;
	r0.z = g_NormalWeightParam.x * r0.z + r2.x;
	r0.z = 1 / r0.z;
	r1.yzw = r1.yzw * r0.www + r3.xyz;
	r1.yzw = r0.zzz * r1.yzw;
	r0.z = r1.y * 2 + -1;
	r2.yz = r1.zw * float2(-1, -2) + float2(-1, 1);
	r0.w = 1 + -i.texcoord2.w;
	r0.w = -r0.w + 1;
	r2.x = r0.w * r0.z;
	r1.yzw = r2.xyz * g_normalmapRate.xxx;
	r2.xyz = normalize(i.texcoord2.xyz);
	r3.xyz = normalize(i.texcoord3.xyz);
	r4.xyz = r2.zxy * r3.yzx;
	r4.xyz = r2.yzx * r3.zxy + -r4.xyz;
	r4.xyz = r1.zzz * r4.xyz;
	r2.xyz = r1.yyy * r2.xyz + r4.xyz;
	r1.yzw = r1.www * r3.xyz + r2.xyz;
	r0.z = dot(g_lightDir.xyz, r3.xyz);
	r2.xyz = normalize(r1.yzw);
	r3.xyz = normalize(-i.texcoord1.xyz);
	r0.w = dot(r2.xyz, r3.xyz);
	r1.y = dot(r3.xyz, g_lightDir.xyz);
	r1.y = r1.y + 1;
	r1.y = r1.y * Incidence_param.z;
	r1.y = r1.y * 0.5;
	r0.w = abs(r0.w);
	r1.z = r0.w * 0.9 + 0.05;
	r0.w = -r0.w + 1;
	r1.w = pow(r0.w, Incidence_param.x);
	r3 = tex2D(g_incidence_sampler, r0);
	r0.xy = r0.xy + g_All_Offset.xy;
	r4.xyz = r1.zzz * r3.xyz;
	r4.xyz = r4.xyz * Incidence_param.yyy;
	r4.xyz = r1.www * r4.xyz;
	r0.w = -r1.y + 1;
	r5 = tex2D(g_Color_1_sampler, r0);
	r6 = tex2D(g_OcclusionSampler, r0);
	r7.xyz = lerp(r5.xyz, r3.xyz, r1.yyy);
	o.color.xyz = r4.xyz * r0.www + r7.xyz;
	r0.xyw = r6.xxx * r7.xyz;
	r1.yz = r6.xz * r6.xz;
	o.color1.xyz = r2.xyz * 0.5 + 0.5;
	r1.w = dot(g_lightDir.xyz, r2.xyz);
	r0.z = -r0.z + r1.w;
	r0.z = r0.z * r1.x + 1;
	r0.xyz = r0.zzz * r0.xyw;
	o.color2.xyz = r0.xyz * g_ambientRate.xyz;
	r0.x = -g_specParam.x;
	r0.x = (-r0.x >= 0) ? 0 : 0.25;
	r0.y = g_specParam.y;
	r0.y = r0.y + g_otherParam.x;
	o.color1.w = r0.x + r0.y;
	r0.x = 1 / i.texcoord7.z;
	r0.xy = r0.xx * i.texcoord8.xy;
	r0.z = 1 / i.texcoord7.w;
	r0.xy = i.texcoord7.xy * r0.zz + -r0.xy;
	r1.x = 0.5;
	o.color3.xy = r0.xy * g_BlurParam.xy + r1.xx;
	r0.x = r1.z * 1.000001;
	o.color.w = r1.y;
	r0.y = abs(g_specParam.x);
	o.color3.z = r0.y * r0.x;
	o.color2.w = 0;
	o.color3.w = g_specParam.z;

	return o;
}
