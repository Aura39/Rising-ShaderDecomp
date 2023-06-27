sampler RefractMap_sampler;
float4 Refract_Param;
float4 SoftPt_Rate;
float4 ambient_rate;
float4 finalcolor_enhance;
float3 fog;
float4 fogParam;
float4 g_CameraParam;
float4 g_TargetUvParam;
float4 g_WtrFogColor;
float4 g_WtrFogParam;
sampler g_Z_sampler;
float4 prefogcolor_enhance;

struct PS_IN
{
	float4 color : COLOR;
	float3 texcoord1 : TEXCOORD1;
	float4 texcoord3 : TEXCOORD3;
	float4 texcoord8 : TEXCOORD8;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	float4 r3;
	float4 r4;
	float4 r5;
	r0.x = dot(i.texcoord3.xyz, i.texcoord3.xyz);
	r0.x = 1 / sqrt(r0.x);
	r0.xy = r0.xx * i.texcoord3.xy;
	r0.z = 1 / i.texcoord8.w;
	r0.zw = r0.zz * i.texcoord8.xy;
	r0.zw = r0.zw * float2(0.5, -0.5) + 0.5;
	r1.xy = r0.zw + g_TargetUvParam.xy;
	r0.z = r1.y + -i.texcoord3.w;
	r0.w = -r0.z + i.texcoord3.w;
	r1.z = (-r0.z >= 0) ? r1.y : r0.w;
	r0 = r0.xyxy * -Refract_Param.y + r1.xyxz;
	r1 = tex2D(g_Z_sampler, r1);
	r1.x = r1.x * g_CameraParam.y + g_CameraParam.x;
	r1.x = r1.x + -i.texcoord8.w;
	r1.x = -r1.x + g_WtrFogParam.w;
	r2 = tex2D(RefractMap_sampler, r0);
	r3.xyz = finalcolor_enhance.xyz;
	r3.w = -1 + i.color.w;
	r4.xz = float2(1, -1);
	r3 = SoftPt_Rate.y * r3 + r4.zzzx;
	r5.xyz = lerp(r2.xyz, r3.xyz, Refract_Param.xxx);
	r5.w = r3.w * ambient_rate.w;
	r2 = r5 + -g_WtrFogColor;
	r0.xy = -g_WtrFogParam.zx + g_WtrFogParam.wy;
	r0.x = 1 / r0.x;
	r0.y = 1 / r0.y;
	r0.x = r0.x * r1.x;
	r1 = r2 * r0.x;
	r0.x = g_WtrFogParam.y + i.texcoord1.z;
	r0.x = r0.y * r0.x;
	r1 = r0.x * r1 + g_WtrFogColor;
	r2 = r1.w + -0.01;
	clip(r2);
	o.w = r1.w * prefogcolor_enhance.w;
	r0.x = r0.w + -0.8;
	r0.xy = r0.xw * 5;
	r0.x = -r0.x + 1;
	r2 = tex2D(RefractMap_sampler, r0.zwzw);
	r0.y = r0.y * Refract_Param.x;
	r0.x = r0.x * r0.y;
	r3.xyz = lerp(r2.xyz, r1.xyz, r0.xxx);
	r0.xyz = r3.xyz * ambient_rate.xyz;
	r1.x = Refract_Param.x;
	r2.xyz = lerp(r4.xxx, prefogcolor_enhance.xyz, r1.xxx);
	r0.xyz = r0.xyz * r2.xyz + -fog.xyz;
	r0.w = -fogParam.x + fogParam.y;
	r0.w = 1 / r0.w;
	r1.x = fogParam.y + i.texcoord1.z;
	r0.w = r0.w * r1.x;
	o.xyz = r0.www * r0.xyz + fog.xyz;

	return o;
}
