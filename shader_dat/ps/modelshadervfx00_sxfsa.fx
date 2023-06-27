sampler Color_1_sampler;
float4 SoftPt_Rate;
float4 ambient_rate;
float3 fog;
float4 g_CameraParam;
float4 g_TargetUvParam;
sampler g_Z_sampler;
float4 prefogcolor_enhance;

struct PS_IN
{
	float4 color : COLOR;
	float2 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
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
	r0.zw = float2(0.5, -0.5);
	r0.x = (SoftPt_Rate.x >= 0) ? r0.w : r0.z;
	r0.y = (-SoftPt_Rate.x >= 0) ? -r0.w : -r0.z;
	r0.x = r0.y + r0.x;
	r0.x = (r0.x >= 0) ? -r0.x : -0;
	r0.y = 1 / i.texcoord8.w;
	r0.yw = r0.yy * i.texcoord8.xy;
	r0.yw = r0.yw * 0.5 + 0.5;
	r0.yw = r0.yw + g_TargetUvParam.xy;
	r1 = tex2D(g_Z_sampler, r0.ywzw);
	r0.y = r1.x * g_CameraParam.y + g_CameraParam.x;
	r0.y = r0.y + -i.texcoord8.w;
	r1.xy = abs(SoftPt_Rate.xz);
	r0.w = 1 / r1.x;
	r0.y = r0.w * r0.y;
	r0.w = -r0.y + 1;
	r0.x = (r0.x >= 0) ? r0.y : r0.w;
	r2 = tex2D(Color_1_sampler, i.texcoord);
	r0.y = r2.w * ambient_rate.w;
	r3 = r0.y * r0.x + -0.01;
	r0.x = r0.x * r0.y;
	clip(r3);
	r0.y = -SoftPt_Rate.z;
	r3.xyz = normalize(-i.texcoord1.xyz);
	r0.w = dot(r3.xyz, i.texcoord3.xyz);
	r0.yw = -r0.yw + 1;
	r1.x = (-r1.y >= 0) ? 0 : 1;
	r1.y = 1 / r1.y;
	r3 = r0.w * -r1.x + r0.y;
	clip(r3);
	r0.y = SoftPt_Rate.z;
	r4 = r0.w * r1.x + -r0.y;
	r0.y = (-r0.y >= 0) ? r3.w : r4.w;
	clip(r4);
	r0.y = r1.y * r0.y;
	r1.w = r0.y * r0.x;
	r0.xy = -r2.yy + r2.xz;
	r2.w = max(abs(r0.x), abs(r0.y));
	r0.x = r2.w + -0.015625;
	r0.y = (-r0.x >= 0) ? 0 : 1;
	r0.x = (r0.x >= 0) ? -0 : -1;
	r0.x = r0.x + r0.y;
	r0.x = (r0.x >= 0) ? -r0.x : -0;
	r2.xz = (r0.xx >= 0) ? r2.yy : r2.xz;
	r1.xyz = r2.xyz * ambient_rate.xyz;
	r2 = -1 + i.color;
	r0 = SoftPt_Rate.y * r2 + r0.z;
	r0 = r0 * r1;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	r0.w = r0.w * prefogcolor_enhance.w;
	o.w = r0.w;
	o.xyz = i.texcoord1.www * r0.xyz + fog.xyz;

	return o;
}
