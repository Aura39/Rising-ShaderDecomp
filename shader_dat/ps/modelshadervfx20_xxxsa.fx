sampler Color_1_sampler;
float4 CubeParam;
float4 Refract_Param;
float4 SoftPt_Rate;
float4 ambient_rate;
float4 finalcolor_enhance;
float3 fog;
float4 g_CameraParam;
float4 g_TargetUvParam;
sampler g_Z_sampler;
float4 lightpos;
sampler normalmap_sampler;
float4 prefogcolor_enhance;
float4 tile;

struct PS_IN
{
	float4 color : COLOR;
	float4 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
	float3 texcoord3 : TEXCOORD3;
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
	r0.x = 1 / i.texcoord8.w;
	r0.xy = r0.xx * i.texcoord8.xy;
	r0.xy = r0.xy * float2(0.5, -0.5) + 0.5;
	r0.xy = r0.xy + g_TargetUvParam.xy;
	r0 = tex2D(g_Z_sampler, r0);
	r0.x = r0.x * g_CameraParam.y + g_CameraParam.x;
	r0.x = r0.x + -i.texcoord8.w;
	r0.y = abs(SoftPt_Rate.x);
	r0.y = 1 / r0.y;
	r0.x = r0.y * r0.x;
	r0.y = -r0.x + 1;
	r0.zw = float2(0.5, -0.5);
	r1.x = (SoftPt_Rate.x >= 0) ? r0.w : r0.z;
	r0.w = (-SoftPt_Rate.x >= 0) ? -r0.w : -r0.z;
	r0.w = r0.w + r1.x;
	r0.w = (r0.w >= 0) ? -r0.w : -0;
	r0.x = (r0.w >= 0) ? r0.x : r0.y;
	r1.xyz = i.texcoord3.xyz;
	r2.xyz = r1.yzx * i.texcoord2.zxy;
	r1.xyz = i.texcoord2.yzx * r1.zxy + -r2.xyz;
	r0.yw = i.texcoord.zw * tile.xy + tile.zw;
	r2 = tex2D(normalmap_sampler, r0.ywzw);
	r2.xyz = r2.xyz + -0.5;
	r1.xyz = r1.xyz * -r2.yyy;
	r0.y = r2.x * i.texcoord2.w;
	r1.xyz = r0.yyy * i.texcoord2.xyz + r1.xyz;
	r1.xyz = r2.zzz * i.texcoord3.xyz + r1.xyz;
	r0.y = dot(r1.xyz, r1.xyz);
	r0.y = 1 / sqrt(r0.y);
	r1.xyz = r1.xyz * r0.yyy + -i.texcoord3.xyz;
	r0.yw = CubeParam.ww * r1.xy + i.texcoord3.xy;
	r1.xyz = r1.xyz * CubeParam.www;
	r1.xyz = Refract_Param.zzz * r1.xyz + i.texcoord3.xyz;
	r1.x = dot(lightpos.xyz, r1.xyz);
	r0.yw = r0.yw * -Refract_Param.yy + i.texcoord.xy;
	r2 = tex2D(Color_1_sampler, r0.ywzw);
	r0.y = r2.w * ambient_rate.w;
	r3 = r0.y * r0.x + -0.01;
	r4.w = r0.x * r0.y;
	clip(r3);
	r0.xy = -r2.yy + r2.xz;
	r1.y = max(abs(r0.x), abs(r0.y));
	r0.x = r1.y + -0.015625;
	r0.y = (-r0.x >= 0) ? 0 : 1;
	r0.x = (r0.x >= 0) ? -0 : -1;
	r0.x = r0.x + r0.y;
	r0.x = (r0.x >= 0) ? -r0.x : -0;
	r2.xz = (r0.xx >= 0) ? r2.yy : r2.xz;
	r0.xyw = r2.xyz * ambient_rate.xyz;
	r1.y = dot(lightpos.xyz, i.texcoord3.xyz);
	r1.x = -r1.y + r1.x;
	r1.x = r1.x * 0.5 + 1;
	r4.xyz = r0.xyw * r1.xxx;
	r1 = -1 + i.color;
	r0 = SoftPt_Rate.y * r1 + r0.z;
	r0 = r0 * r4;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	r1.w = r0.w * prefogcolor_enhance.w;
	r1.xyz = i.texcoord1.www * r0.xyz + fog.xyz;
	o = r1 * finalcolor_enhance;

	return o;
}
