sampler Caustics_sampler : register(s4);
sampler Color_1_sampler : register(s0);
sampler Color_2_sampler : register(s1);
float4 CubeParam : register(c42);
sampler RefractMap_sampler : register(s12);
float4 Refract_Param : register(c43);
float4 SoftPt_Rate : register(c44);
float4 ambient_rate : register(c40);
float4 blendTile : register(c49);
samplerCUBE cubemap_sampler : register(s2);
float4 finalcolor_enhance : register(c78);
float3 fog : register(c67);
float4 g_CameraParam : register(c193);
float4 g_CausticsParam : register(c47);
float4 g_TargetUvParam : register(c194);
float4 g_WtrFogColor : register(c46);
float4 g_WtrFogParam : register(c45);
sampler g_Z_sampler : register(s13);
float4 light_Color : register(c61);
float4 lightpos : register(c62);
sampler normalmap_sampler : register(s3);
float4 prefogcolor_enhance : register(c77);
float4x4 proj : register(c4);
float4 tile : register(c48);
float4x4 viewInverseMatrix : register(c12);

struct PS_IN
{
	float4 color : COLOR;
	float4 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
	float4 texcoord3 : TEXCOORD3;
	float3 texcoord4 : TEXCOORD4;
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
	float3 r6;
	r0.xyz = i.texcoord3.xyz;
	r1.xyz = r0.yzx * i.texcoord2.zxy;
	r0.xyz = i.texcoord2.yzx * r0.zxy + -r1.xyz;
	r1.xy = i.texcoord.zw * blendTile.xy + blendTile.zw;
	r1 = tex2D(Color_2_sampler, r1);
	r1.zw = i.texcoord.zw * tile.xy + tile.zw;
	r2 = tex2D(normalmap_sampler, r1.zwzw);
	r2.xyz = r2.xyz + -0.5;
	r1.xy = r1.xy + r2.xy;
	r1.xy = r1.xy + -0.5;
	r0.xyz = r0.xyz * -r1.yyy;
	r0.w = r1.x * i.texcoord2.w;
	r0.xyz = r0.www * i.texcoord2.xyz + r0.xyz;
	r0.xyz = r2.zzz * i.texcoord3.xyz + r0.xyz;
	r0.w = dot(r0.xyz, r0.xyz);
	r0.w = 1 / sqrt(r0.w);
	r0.xyz = r0.xyz * r0.www + -i.texcoord3.xyz;
	r1.xy = CubeParam.ww * r0.xy + i.texcoord3.xy;
	r0.xyz = r0.xyz * CubeParam.www;
	r0.xyz = Refract_Param.zzz * r0.xyz + i.texcoord3.xyz;
	r0.w = 1 / i.texcoord8.w;
	r1.zw = r0.ww * i.texcoord8.xy;
	r2.xy = r1.zw * float2(0.5, -0.5) + 0.5;
	r2.xy = r2.xy + g_TargetUvParam.xy;
	r0.w = r2.y + -i.texcoord3.w;
	r2.w = -r0.w + i.texcoord3.w;
	r2.z = (-r0.w >= 0) ? r2.y : r2.w;
	r3 = r1.xyxy * -Refract_Param.y + r2.xyxz;
	r4 = tex2D(g_Z_sampler, r3);
	r0.w = r4.x * g_CameraParam.y + g_CameraParam.x;
	r2.z = -r0.w + abs(i.texcoord1.z);
	r4 = tex2D(g_Z_sampler, r2);
	r2.xy = (-r2.zz >= 0) ? r3.xy : r2.xy;
	r5 = tex2D(RefractMap_sampler, r2);
	r2.x = r4.x * g_CameraParam.y + g_CameraParam.x;
	r0.w = (-r2.z >= 0) ? r0.w : r2.x;
	r2.x = r2.x + -i.texcoord8.w;
	r1.zw = r0.ww * r1.zw;
	r3.x = 1 / transpose(proj)[0].x;
	r3.y = 1 / transpose(proj)[1].y;
	r4.xy = r1.zw * r3.xy;
	r4.z = -r0.w;
	r0.w = r0.w + -i.texcoord8.w;
	r0.w = -r0.w + g_WtrFogParam.w;
	r4.w = 1;
	r3.x = dot(r4, transpose(viewInverseMatrix)[0]);
	r3.y = dot(r4, transpose(viewInverseMatrix)[2]);
	r1.z = dot(r4, transpose(viewInverseMatrix)[1]);
	r1.z = r1.z * 0.01;
	r2.yz = r3.xy * g_CausticsParam.xy;
	r1.zw = r2.yz * 0.1 + r1.zz;
	r1.xy = r1.xy * -Refract_Param.yy + r1.zw;
	r1 = tex2D(Caustics_sampler, r1);
	r1.xyz = r1.xyz * g_CausticsParam.zzz;
	r1.xyz = r1.xyz * light_Color.xyz;
	r4.xyz = finalcolor_enhance.xyz;
	r4.w = -1 + i.color.w;
	r2.zw = float2(0.5, -0.5);
	r4 = SoftPt_Rate.y * r4 + r2.wwwz;
	r6.xyz = lerp(r5.xyz, r4.xyz, Refract_Param.xxx);
	r4.w = r4.w * ambient_rate.w;
	r4.xyz = r1.xyz * r6.xyz + r6.xyz;
	r1.xy = -g_WtrFogParam.zx + g_WtrFogParam.wy;
	r1.x = 1 / r1.x;
	r1.y = 1 / r1.y;
	r0.w = r0.w * r1.x;
	r5 = lerp(r4, g_WtrFogColor, r0.w);
	r4 = tex2D(Color_1_sampler, i.texcoord);
	r0.w = 1 / SoftPt_Rate.w;
	r0.w = r0.w * r2.x;
	r0.w = -r0.w + 1;
	r4 = r4 * r0.w + r5;
	r0.w = g_WtrFogParam.y + i.texcoord1.z;
	r0.w = r1.y * r0.w;
	r1 = lerp(r4, g_WtrFogColor, r0.w);
	r0.w = abs(SoftPt_Rate.x);
	r0.w = 1 / r0.w;
	r0.w = r0.w * r2.x;
	r2.x = -r0.w + 1;
	r2.y = (SoftPt_Rate.x >= 0) ? r2.w : r2.z;
	r2.w = (-SoftPt_Rate.x >= 0) ? -r2.w : -r2.z;
	r2.y = r2.w + r2.y;
	r2.y = (r2.y >= 0) ? -r2.y : -0;
	r0.w = (r2.y >= 0) ? r0.w : r2.x;
	r4 = r1.w * r0.w + -0.01;
	r0.w = r0.w * r1.w;
	o.w = r0.w * prefogcolor_enhance.w;
	clip(r4);
	r4.x = dot(r0.xyz, transpose(viewInverseMatrix)[0].xyz);
	r4.y = dot(r0.xyz, transpose(viewInverseMatrix)[1].xyz);
	r4.z = dot(r0.xyz, transpose(viewInverseMatrix)[2].xyz);
	r0.w = dot(i.texcoord4.xyz, r4.xyz);
	r0.w = r0.w + r0.w;
	r4.xyz = r4.xyz * -r0.www + i.texcoord4.xyz;
	r4.w = -r4.z;
	r4 = tex2D(cubemap_sampler, r4.xyww);
	r5.xyz = normalize(-i.texcoord1.xyz);
	r0.w = dot(r5.xyz, r0.xyz);
	r0.x = dot(lightpos.xyz, r0.xyz);
	r0.y = -r0.w + 1;
	r1.w = pow(r0.y, SoftPt_Rate.z);
	r0.y = max(0.001, r1.w);
	r0.yzw = r0.yyy * r4.xyz;
	r1.w = r4.w * CubeParam.y + CubeParam.x;
	r0.yzw = r0.yzw * r1.www;
	r1.w = r3.w + -0.8;
	r1.w = r1.w * 5;
	r1.w = -r1.w + 1;
	r2.x = r3.w * 5;
	r3 = tex2D(RefractMap_sampler, r3.zwzw);
	r2.x = r2.x * Refract_Param.x;
	r1.w = r1.w * r2.x;
	r2.xyw = lerp(r3.xyz, r1.xyz, r1.www);
	r1.xyz = r0.yzw * r2.xyw;
	r2.xyw = r2.xyw * ambient_rate.xyz;
	r1.w = dot(lightpos.xyz, i.texcoord3.xyz);
	r0.x = r0.x + -r1.w;
	r0.x = r0.x * 0.5 + 1;
	r2.xyw = r0.xxx * r2.xyw;
	r3.xyz = r1.xyz * CubeParam.zzz + r2.xyw;
	r1.xyz = r1.xyz * CubeParam.zzz;
	r1.xyz = r2.xyw * -r1.xyz + r3.xyz;
	r0.x = r2.z + -CubeParam.z;
	r0.xyz = r0.yzw * r0.xxx + r1.xyz;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord1.www * r0.xyz + fog.xyz;

	return o;
}
